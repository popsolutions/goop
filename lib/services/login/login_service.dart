import 'dart:convert';

import 'package:goop/utils/global.dart';

import '../../config/exceptions/authentication_exception.dart';
import '../../config/http/odoo_api.dart';
import '../../models/login_dto.dart';
import '../../models/login_result.dart';

class LoginServiceImpl {
  final Odoo _odoo;
  LoginServiceImpl(this._odoo);

  Future<LoginResult> login(LoginDto loginDto) async {
    final path = _odoo.createPath("/web/session/authenticate");
    final params = {
      "db": globalConfig.dbName,
      "login": loginDto.username,
      "password": loginDto.password,
      "context": {}
    };
    final response =
        await _odoo.callDbRequest(path, _odoo.createPayload(params));

    final data = jsonDecode(response.body);
    if (data["error"] != null) {
      throw AuthenticationException("invalid username or password");
    }
    return LoginResult.fromJson(data['result']);
    
  }
}
