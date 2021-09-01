import 'package:goop/config/http/odoo_api.dart';

class absService {
  final Odoo odoo = Odoo();

  Future<List> searchReadGen(String model, {dynamic filter, dynamic fields, int offset = 0, int limit = 0, String order = ""}) async {
    return await odoo.searchReadGen(model, filter: filter, fields: fields, offset: offset, limit: limit, order: order);
  }
}
