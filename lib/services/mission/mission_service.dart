import 'dart:async';
import 'dart:io';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/establishment.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/ActivityService.dart';
import 'package:goop/services/GeoLocService.dart';
import 'package:goop/services/constants.dart';
import 'package:goop/services/establishment/establishment_service.dart';
import 'package:goop/services/measurementService.dart';
import 'package:goop/utils/ClassConstants.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';

import '../../models/activity.dart';
import '../../models/mission.dart';
import '../../models/mission.dart';
import '../../models/mission.dart';
import '../../utils/ClassConstants.dart';

class MissionService {
  final Odoo _odoo;
  ActivityService activityService = new ActivityService();
  EstablishmentService establishmentService = new EstablishmentService(Odoo());
  MeasurementService measurementService = new MeasurementService();

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

    setMeasurementModelToListMissionModel(listMission);

    return listMission;
  }

  void setMissionEstablishment(MissionModel mission) async {
    EstablishmentModel establishmentModel = await establishmentService.getEstablishmentModelById(mission.establishmentId);
    mission.address = establishmentModel.address;
    LoadControl_getMissions += 1;
  }

  Future<void> setListActivity(MissionModel missionModel, User user) async {
    missionModel.listActivity  = await getListActivity(missionModel);
    await updateListActivityChecked(missionModel, user);
  }

  Future<List<Activity>> getListActivity(MissionModel missionModel) async {
    List<Activity> listPhoto = await activityService.getListPhotoFromMission(missionModel);
    List<Activity> listQuizz = await activityService.getListQuizzFromMission(missionModel);
    List<Activity> listPriceComparison = await activityService.getListPriceComparisonFromMission(missionModel);

    return listPhoto + listQuizz + listPriceComparison;
  }

  Future<void> updateListActivityChecked(MissionModel missionModel, User user) async {
    if (missionModel.measurementModel == null)
      missionModel.measurementModel = await getMeasurementModel(missionModel, user.partnerId);

    if (missionModel.measurementModel != null) {
      
      for (var activity in missionModel.listActivity) {
        if (activity.isQuizz() == true) {
          await activityService.setMeasurementQuizzlinesModel(activity, missionModel.measurementModel, user);
        } else if (activity.isPhoto() == true) {
          await activityService.setMeasurementPhotoLinesModel(activity, missionModel.measurementModel, user);
        } else if (activity.isPriceComparison() == true) {
          await activityService.setMeasurementPriceComparisonLinesModel(activity, missionModel.measurementModel, user);
        }
      }
    }
  }

  void updateMissionModel(MissionModel missionModel) async {
    await _odoo.write(
      Strings.missions,
      [missionModel.id],
      missionModel.toJson(),
    );
  }

  void setMeasurementModelToListMissionModel(List<MissionModel> listMissionModel) async {
    for (MissionModel missionModel in listMissionModel){
      missionModel.measurementModel = await getMeasurementModel(missionModel, globalcurrentUser.partnerId);
    }

    globalServiceNotifier.notifyListeners();
  }

  Future<MeasurementModel> getMeasurementModel(MissionModel missionModel, int partner_id) async {
    MeasurementModel measurementModel = await measurementService.getMeasurementModelFromMissionAndPartner_id(missionModel, partner_id);
    return measurementModel;
  }

  Future<void> createMeasurementModel(MissionModel missionModel, User currentUser, GeoLocService geoLocService) async {

    MeasurementModel measurementModelExistent = await getMeasurementModel(missionModel, currentUser.partnerId);

    if (measurementModelExistent != null){
      missionModel.measurementModel = measurementModelExistent;
    }else {
      geoLocService.update();

      MeasurementModel measurementModelInsert = MeasurementModel(
        id: null,
        mission_Id: missionModel.id,
        name: '//??-marcos-',
        partner_Id: currentUser.partnerId,
        partner_Name: null,
        state: 'done',
        dateStarted: DateTime.now(),
        // dateFinished: "2021-05-02",
        measurementLatitude: geoLocService.latitude,
        measurementLongitude: geoLocService.longitude,
        // lines_ids: [],
        // quizz_lines_ids: [],
        // photo_lines_ids: [],
        // price_comparison_lines_ids: [],
        // color: 0,
        // priority: "0",
        // sequence: 10,
        active: true,
        kanbanState: "draft",
        // legendPriority: false,
        legendBlocked: "Ready",
        legendDone: "Done",
        legendNormal: "Pending",
        legendDoing: "In Progress",
        create_Uid: currentUser.uid,
        create_Uname: null,
        // createDate: "2021-05-31 21:10:12",
        write_Uid: currentUser.uid,
        write_Uname: null,
        // writeDate: "2021-05-31 21:12:27",
        kanbanStateLabel: "Pending",
        displayName: "'//??-marcos'",
        // lastUpdate: null
      );

      MeasurementModel measurementModelInserted = await measurementService.insertAndGet(measurementModelInsert);

      missionModel.measurementModel = measurementModelInserted;
    }
  }
}
