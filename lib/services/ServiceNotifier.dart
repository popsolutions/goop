import 'package:flutter/cupertino.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/models/AlternativeModel.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurementPhotoLines.dart';
import 'package:goop/models/measurementPriceComparisonLines.dart';
import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/ActivityService.dart';
import 'package:goop/services/AlternativeService.dart';
import 'package:goop/services/GeoLocService.dart';
import 'package:goop/services/MeasurementPhotoLinesService.dart';
import 'package:goop/services/MeasurementQuizzlinesService.dart';
import 'package:goop/utils/global.dart';

import '../config/http/odoo_api.dart';
import '../pages/mission_page/mission_controller.dart';
import 'establishment/establishment_controller.dart';
import 'establishment/establishment_service.dart';
import 'measurementPriceComparisonLinesService.dart';
import 'measurementService.dart';
import 'mission/mission_service.dart';

class ServiceNotifier extends ChangeNotifier {
  // ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);
  AlternativeService alternativeService = new AlternativeService();
  MeasurementService measurementService = new MeasurementService();
  GeoLocService geoLocService = new GeoLocService();
  MeasurementQuizzlinesService measurement_quizzlinesService =
      MeasurementQuizzlinesService();
  MeasurementPhotoLinesService measurementPhotoLinesService =
      MeasurementPhotoLinesService();
  MissionService missionService = new MissionService(Odoo());
  ActivityService activityService = new ActivityService();
  AuthenticationController authenticationController =
      new AuthenticationController();
  MeasurementPriceComparisonLinesService
      measurementPriceComparisonLinesService =
      new MeasurementPriceComparisonLinesService();

  bool initialization = false;
  Activity currentActivity;
  User currentUser;
  MissionModel currentMissionModel = MissionModel();

  List<AlternativeModel> listAlternativeModel = <AlternativeModel>[];
  List<MissionModel> listMissionModel = <MissionModel>[];

  final missionsController = MissionController(MissionService(Odoo()));

  final establishmentsController =
      EstablishmentController(EstablishmentService(Odoo()));

  init() async {
    if (initialization == true) return;
    update();
    globalServiceNotifier = this;
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

  Future<void> insert_Measurement_quizzlinesModel(
      QuizzLinesModel _selectedQuizzLinesModel) async {
    await createMeasurementModelIfNotExists();

    MeasurementQuizzlinesModel measurement_quizzlinesModel =
        MeasurementQuizzlinesModel(
            name: "//??-marcos",
            quizz_id: currentActivity.id,
            alternative_id: _selectedQuizzLinesModel.alternative_id,
            measurement_id: currentMissionModel.measurementModel.id,
            create_uid: currentUser.uid,
            write_uid: currentUser.uid);

    await measurement_quizzlinesService.insert(measurement_quizzlinesModel);

    await activityService.setMeasurementQuizzlinesModel(
        currentActivity, currentMissionModel.measurementModel, currentUser);

    notifyListeners();
  }

  Future<void> createMeasurementModelIfNotExists() async {
    if (currentMissionModel.measurementModel == null) {
      await missionService.createMeasurementModel(
          currentMissionModel, currentUser, geoLocService);
    }
  }

  Future<void> insert_Measurement_photolines(String photoBase64) async {
    await createMeasurementModelIfNotExists();

    MeasurementPhotoLinesModel measurementPhotoLinesModel =
        MeasurementPhotoLinesModel(
            name: "//??-marcos",
            measurement_id: currentMissionModel.measurementModel.id,
            photo_id: currentActivity.id,
            photo: photoBase64,
            create_uid: currentUser.uid,
            write_uid: currentUser.uid);

    await measurementPhotoLinesService.insert(measurementPhotoLinesModel);

    await activityService.setMeasurementPhotoLinesModel(
        currentActivity, currentMissionModel.measurementModel, currentUser);

    notifyListeners();
  }

  Future<void> insert_Measurement_PriceComparisonLinesModel(
      double price, String photoBase64) async {
    await createMeasurementModelIfNotExists();

    MeasurementPriceComparisonLinesModel measurementPriceComparisonLinesModel =
        MeasurementPriceComparisonLinesModel(
            display_name: "//??-marcos",
            measurement_id: currentMissionModel.measurementModel.id,
            product_id: currentActivity.product_id,
            price: price,
            photo: photoBase64,
            create_uid: currentUser.uid,
            write_uid: currentUser.uid);

    await measurementPriceComparisonLinesService
        .insert(measurementPriceComparisonLinesModel);
    await activityService.setMeasurementPriceComparisonLinesModel(
        currentActivity, currentMissionModel.measurementModel, currentUser);

    notifyListeners();
  }

  setcurrentMissionModel(MissionModel missionModel) async {
    //??-mateus
    //Se o usuário sair da tela de mensuração e retornar novamente, precisarei setar a mensuração em progresso.

    await missionService.setListActivity(missionModel, currentUser);
    currentMissionModel = missionModel;
    currentMissionModel.measurementModel = await missionService
        .getMeasurementModel(currentMissionModel, currentUser.partnerId);
  }

  setcurrentActivity(Activity activity) async {
    currentActivity = activity;

    if (activity.isQuizz())
      await activityService.setQuizzLinesFromActivity(currentActivity);
  }

  setCurrentUser(User user) {
    currentUser = user;
    globalcurrentUser = currentUser;
  }
}
