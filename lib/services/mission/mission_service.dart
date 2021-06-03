import 'dart:async';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/establishment.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/services/constants.dart';
import 'package:goop/utils/ClassConstants.dart';

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
    final listMission = json.map((e) => MissionModel.fromJson(e)).toList();
    for (var i = 0; i < listMission.length; i++) {
      setMissionEstablishment(listMission[i]);
    }

    setMissionActivityList(listMission);
    return listMission;
  }

  void setMissionEstablishment(MissionModel mission) async {
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

  void setMissionActivityList(List<MissionModel> listMissionModel) async {
    setMissionActivity(listMissionModel, Strings.photoLines, ActivityTypeConsts.Photo);
    setMissionActivity(listMissionModel, Strings.popsQuizz, ActivityTypeConsts.Quizz);
    setMissionActivity(listMissionModel, Strings.price_comparison, ActivityTypeConsts.Price_Comparison);
  }

  void setMissionActivity(List<MissionModel> listMissionModel, String model, String activityType) async {
    try {
      final response = await _odoo.searchRead(
        model,
        [],
        [],
      );
      final List json = response.getRecords();

      List<Activity> listActivity = [];

      json.forEach((element) {
        Activity activity = Activity.fromJson(element, activityType);

        if (activity != null) listActivity.add(activity);
      });

      for (var i = 0; i < listMissionModel.length; i++) {
        for (var j = 0; j < listActivity.length; j++) {
          if (listActivity[j].mission_id == listMissionModel[i].id)
            listMissionModel[i].listActivity.add(listActivity[j]);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
