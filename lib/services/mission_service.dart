import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/services/constants.dart';

class MissionService {
  final Odoo _odoo;

  MissionService(this._odoo);

  Future<MissionModel> getMission(int id) async {
    final response = await _odoo.searchRead(Strings.missions, [
      ["id", "=", id]
    ], []);

    final json = response.getResult()['records'];
    return MissionModel.fromJson(json);
  }
}
