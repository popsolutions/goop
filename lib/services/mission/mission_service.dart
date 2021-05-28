import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/services/constants.dart';

class MissionService {
  final Odoo _odoo;
  MissionService(this._odoo);

  Future<List<MissionModel>> getMissions() async {
    final response = await _odoo.searchRead(
      Strings.missions,
      [
        ['state', '=', 'open']
      ],
      [],
    );
    final List json = response.getRecords();
    return json.map((e) => MissionModel.fromJson(e)).toList();
  }
}
