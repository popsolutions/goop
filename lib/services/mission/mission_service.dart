import 'dart:async';

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

    // for (var c = 0; c < 200; c++) {
    //   mapa.add(mapa[0]);
    //   mapa.add(mapa[1]);
    // }

    for (var c = 0; c < mapa.length; c++) {
      setMission(mapa[c], c);
    }

    return mapa;
  }

  void setMission(MissionModel mission, int c) async {
    final response = await _odoo.searchRead(
      Strings.establishment,
      [
        ['id', '=', mission.establishmentId]
      ],
      [],
    );
    final List json = response.getRecords();
    final mapa = json.map((e) => EstablishmentModel.fromJson(e)).toList();
    mission.address = mapa[0].address;
  }
}
