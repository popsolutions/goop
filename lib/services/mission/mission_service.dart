import 'dart:async';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/establishment.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/services/ActivityService.dart';
import 'package:goop/services/constants.dart';
import 'package:goop/services/establishment/establishment_service.dart';
import 'package:goop/utils/ClassConstants.dart';

import '../../models/activity.dart';
import '../../models/mission.dart';
import '../../models/mission.dart';
import '../../models/mission.dart';
import '../../utils/ClassConstants.dart';

class MissionService {
  final Odoo _odoo;
  ActivityService activityService = new ActivityService();
  EstablishmentService establishmentService = new EstablishmentService(Odoo());


  MissionService(this._odoo);

  int LoadControl_getMissions = 0; // is complet if

  bool getMissionsCompletLoad() => (LoadControl_getMissions >= 4);

  Future<MissionModel> getMissionById(int id) async {
    LoadControl_getMissions = 0;
    final response = await _odoo.searchRead(
      Strings.missions,
      [
        ['id', '=', id.toString()]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    MissionModel missionModel = MissionModel.fromJson(json[0]);

    await setMissionEstablishment(missionModel);
    return missionModel;
  }

  Future<List<MissionModel>> getOpenMissions() async {
    LoadControl_getMissions = 0;
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

    return listMission;
  }

  void setMissionEstablishment(MissionModel mission) async {
    EstablishmentModel establishmentModel = await establishmentService.getEstablishmentModelById(mission.establishmentId);
    mission.address = establishmentModel.address;
    LoadControl_getMissions += 1;
  }

  Future<void> setListActivity(MissionModel missionModel) async {
    missionModel.listActivity  = await getListActivity(missionModel);
  }

  Future<List<Activity>> getListActivity(MissionModel missionModel) async {
    List<Activity> listPhoto = await activityService.getListActivityModelFromMission(missionModel, Strings.photoLines, 'mission_id');
    List<Activity> listQuizz = await activityService.getListActivityModelFromMission(missionModel, Strings.popsQuizz);
    List<Activity> listPriceComparison = await activityService.getListActivityModelFromMission(missionModel, Strings.price_comparison);

    return listPhoto + listQuizz + listPriceComparison;
  }

  void updateMissionModel(MissionModel missionModel) async {
    await _odoo.write(
      Strings.missions,
      [missionModel.id],
      missionModel.toJson(),
    );
  }
}
