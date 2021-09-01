import 'dart:async';
import 'dart:convert';
import 'package:goop/utils/GoopClass.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'odoo_response.dart';
import 'odoo_version.dart';

class Odoo extends GoopClass {

  http.Client _client = http.Client();
  get _serverURL => globalConfig.serverURL;
  Map<String, String> _headers = {};
  OdooVersion version = new OdooVersion();
  String _sessionId;
  int _uid;

  String createPath(String path) {
    return _serverURL + path;
  }

  setSessionId(String sessionIid) {
    _sessionId = sessionIid;
  }

  Future<OdooResponse> getSessionInfo() async {
    var url = createPath("/web/session/get_session_info");
    return await callRequest(url, createPayload({}));
  }

  Future<OdooResponse> destroy() async {
    var url = createPath("/web/session/destroy");
    final res = await callRequest(url, createPayload({}));
    prefsGoop.remove("session");
    return res;
  }

  // Authenticate user
  Future<http.Response> authenticate(
      String username, String password, String database) async {
    var url = createPath("/web/session/authenticate");
    var params = {
      "db": globalConfig.dbName,
      "login": username,
      "password": password,
      "context": {}
    };
    final response = await callDbRequest(url, createPayload(params));
    return response;
  }

  Future<OdooResponse> read(String model, List<int> ids, List<String> fields,
      {dynamic kwargs, Map context}) async {
    return await callKW(model, "read", [ids, fields],
        kwargs: kwargs, context: context);
  }

  Future<OdooResponse> searchRead(
      String model, List domain, List<String> fields,
      {int offset = 0, int limit = 0, String order = ""}) async {
    var url = createPath("/web/dataset/search_read");
    var params = {
      "context": getContext(),
      "domain": domain,
      "fields": fields,
      "limit": limit,
      "model": model,
      "offset": offset,
      "sort": order
    };
    return await callRequest(url, createPayload(params));
  }

  Future<List> searchReadGen(String model, {dynamic filter, dynamic fields, int offset = 0, int limit = 0, String order = ""}) async {
    final response = await this.searchRead(model, filter, fields, offset: offset, limit: limit, order: order);
    final List json = response.getRecords();
    // final listMission = json.map((e) => MissionModel.fromJson(e)).toList();
    return json;
  }

  // Call any model method with arguments
  Future<OdooResponse> callKW(String model, String method, List args,
      {dynamic kwargs, Map context}) async {
    kwargs = kwargs == null ? {} : kwargs;
    context = context == null ? {} : context;
    var url = createPath("/web/dataset/call_kw/" + model + "/" + method);
    var params = {
      "model": model,
      "method": method,
      "args": args,
      "kwargs": kwargs,
      "context": context
    };
    return await callRequest(url, createPayload(params));
  }

  // Create new record for model
  Future<OdooResponse> create(String model, Map values) async {
    return await callKW(model, "create", [values]);
  }

  // Write record with ids and values
  // atualizar
  Future<OdooResponse> write(String model, List<int> ids, Map values) async {
    return await callKW(model, "write", [ids, values]);
  }

  // Remove record from system
  // deletar
  Future<OdooResponse> unlink(String model, List<int> ids) async {
    return await callKW(model, "unlink", [ids]);
  }

  // Call json controller
  Future<OdooResponse> callController(String path, Map params) async {
    return await callRequest(createPath(path), createPayload(params));
  }

  String getSessionId() {
    return _sessionId;
  }

  // connect to odoo and set version and databases
  Future<OdooVersion> connect() async {
    OdooVersion odooVersion = await getVersionInfo();
    return odooVersion;
  }

  // get version of odoo
  Future<OdooVersion> getVersionInfo() async {
    var url = createPath("/web/webclient/version_info");
    final response = await callRequest(url, createPayload({}));
    version = OdooVersion().parse(response);
    return version;
  }

  Future<http.Response> getDatabases() async {
    var serverVersionNumber = await getVersionInfo();

    if (serverVersionNumber.getMajorVersion() == null) {
      version = await getVersionInfo();
    }
    String url = getServerURL();
    var params = {};
    if (serverVersionNumber != null) {
      if (serverVersionNumber.getMajorVersion() == 9) {
        url = createPath("/jsonrpc");
        params["method"] = "list";
        params["service"] = "db";
        params["args"] = [];
      } else if (serverVersionNumber.getMajorVersion() >= 10) {
        url = createPath("/web/database/list");
        params["context"] = {};
      } else {
        url = createPath("/web/database/get_list");
        params["context"] = {};
      }
    }
    final response = await callDbRequest(url, createPayload(params));
    return response;
  }

  String getServerURL() {
    return _serverURL;
  }

  Map createPayload(Map params) {
    return {
      "id": new Uuid().v1(),
      "jsonrpc": "2.0",
      "method": "call",
      "params": params,
    };
  }

  Map getContext() {
    return {"lang": "en_US", "tz": "Europe/Brussels", "uid": _uid};
  }

  Future<OdooResponse> callRequest(String url, Map payload) async {
    final response = await callDbRequest(url, payload);
    OdooResponse odooResponse = new OdooResponse(json.decode(response.body), response.statusCode);

    if (odooResponse.hasError())
      throwG(odooResponse.getErrorMessage(), 'callRequest');

    return odooResponse;
  }

  Future<http.Response> callDbRequest(String url, Map payload) async {
    var body = json.encode(payload);
    _headers["Content-type"] = "application/json; charset=UTF-8";
    _headers["Cookie"] = prefsGoop.getString(Constants.SESSION);
    printL("------------------------------------------->>>>");
    printL("REQUEST: $url\n");
    printL("BODY:\n $body\n");
    printL("HEADERS.:");
    _headers.forEach((key, value) {printL(key + ':' + (value ?? '') + '\n');});
    printL("------------------------------------------->>>>");
    final response =
        await _client.post(Uri.parse(url), body: body, headers: _headers);
    _updateCookies(response);
    printL("<<<<============================================");
    printL("RESPONSE: ${response.body}");
    printL("<<<<============================================");
    return response;
  }

  _updateCookies(http.Response response) async {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      _headers['Cookie'] = rawCookie;
      prefsGoop.setString(Constants.SESSION, rawCookie);
    }
  }

  Future<http.Response> check() {
    var url = createPath("/web/session/check");
    final res = callDbRequest(url, createPayload({}));
    return res;
  }

  Future<OdooResponse> hasRight(String model, List right) {
    var url = createPath("/web/dataset/call_kw");
    var params = {
      "model": model,
      "method": "has_group",
      "args": right,
      "kwargs": {},
      "context": getContext()
    };
    final res = callRequest(url, createPayload(params));
    return res;
  }
}

class Constants {
  static const String UID = "uid";
  static const String SESSION_ID = "session_id";
  static const String USER_PREF = "UserPrefs";
  static const String ODOO_URL = "odooUrl";
  static const String SESSION = "session";
  static const String PERSON_ID = "person_id";
}
