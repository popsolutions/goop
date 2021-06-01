import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/establishment.dart';
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
    final mapa = json.map((e) => MissionModel.fromJson(e)).toList();
    await getOpenMissions(mapa);
    return mapa;
  }

  //
  Future<dynamic> getOpenMissions(List<MissionModel> lista) async {
    for (var c = 0; c < lista.length; c++) {
      final element = lista[c];
      final response = await _odoo.searchRead(
        Strings.establishment,
        [
          ['id', '=', element.establishmentId]
        ],
        [],
      );
      final List json = response.getRecords();
      final mapa = json.map((e) => EstablishmentModel.fromJson(e)).toList();
      element.address = mapa[0].address;
    }
  }
}
