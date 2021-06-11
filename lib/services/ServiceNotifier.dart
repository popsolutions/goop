import 'package:flutter/cupertino.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/models/AlternativeModel.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/ActivityService.dart';
import 'package:goop/services/AlternativeService.dart';
import 'package:goop/services/GeoLocService.dart';
import 'package:goop/services/MeasurementQuizzlinesService.dart';
import 'package:goop/utils/utils.dart';

import '../config/http/odoo_api.dart';
import '../pages/mission_page/mission_controller.dart';
import '../utils/goop_images.dart';
import 'establishment/establishment_controller.dart';
import 'establishment/establishment_service.dart';
import 'measurementService.dart';
import 'mission/mission_service.dart';
import 'mission/mission_service.dart';
import 'mission/mission_service.dart';

class ServiceNotifier{
  // ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);
  AlternativeService alternativeService = new AlternativeService();
  MeasurementService measurementService = new MeasurementService();
  GeoLocService geoLocService = new GeoLocService();
  MeasurementQuizzlinesService measurement_quizzlinesService = MeasurementQuizzlinesService();
  MissionService missionService = new MissionService(Odoo());
  ActivityService activityService = new ActivityService();
  AuthenticationController authenticationController = new AuthenticationController();

  bool initialization = false;
  Activity currentActivity;
  User currentUser;
  MissionModel currentMissionModel = new MissionModel();

  List<AlternativeModel> listAlternativeModel = <AlternativeModel>[];
  List<MissionModel> listMissionModel = <MissionModel>[];

  final missionsController = MissionController(MissionService(Odoo()));

  final establishmentsController = EstablishmentController(EstablishmentService(Odoo()));

  init() async {
    if (initialization == true) return;
    update();
    initialization = true;
  }

  update() {
    listAlternativeModelLoad();
    missionsController.load();
    establishmentsController.load();
    listMissionModel = missionsController.missionsRequest.value;
  }

  void listAlternativeModelLoad() async {
    listAlternativeModel = await alternativeService.getAlternativeService();
  }

  Future<void> insert_Measurement_quizzlinesModel(QuizzLinesModel _selectedQuizzLinesModel) async {
    if (currentMissionModel.measurementModel == null) {
      await missionService.createMeasurementModel(currentMissionModel, currentUser, geoLocService);
    }

    MeasurementQuizzlinesModel measurement_quizzlinesModel = MeasurementQuizzlinesModel(
        name: "//??-marcos",
        quizz_id: currentActivity.id,
        alternative_id: _selectedQuizzLinesModel.alternative_id,
        measurement_id: currentMissionModel.measurementModel.id,
        create_uid: currentUser.uid,
        write_uid: currentUser.uid);

    MeasurementQuizzlinesModel measurement_quizzlinesModelInserted =
        await measurement_quizzlinesService.insertAndGet(measurement_quizzlinesModel);

    await activityService.setMeasurementQuizzlinesModel(currentActivity,  currentMissionModel.measurementModel, currentUser);
    print(measurement_quizzlinesModelInserted);
  }

  setcurrentMissionModel(MissionModel missionModel) async {
    //??-mateus
    //Se o usuário sair da tela de mensuração e retornar novamente, precisarei setar a mensuração em progresso.

    await missionService.setListActivity(missionModel, currentUser);
    currentMissionModel = missionModel;
    currentMissionModel.measurementModel = await missionService.getMeasurementModel(currentMissionModel, currentUser.partnerId);
  }

  setcurrentActivity(Activity activity) async {
    currentActivity = activity;

    if (activity.isQuizz())
      await activityService.setQuizzLinesFromActivity(currentActivity);
  }
}
