import 'package:flutter/cupertino.dart';
import 'package:goop/models/AlternativeModel.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurement_quizzlines.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/AlternativeService.dart';
import 'package:goop/services/GeoLocService.dart';
import 'package:goop/services/Measurement_quizzlinesService.dart';
import 'package:goop/utils/utils.dart';

import '../config/http/odoo_api.dart';
import '../pages/mission_page/mission_controller.dart';
import 'establishment/establishment_controller.dart';
import 'establishment/establishment_service.dart';
import 'measurementService.dart';
import 'mission/mission_service.dart';

class ServiceNotifier {
  //ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);
  AlternativeService alternativeService = new AlternativeService();
  MeasurementService measurementService = new MeasurementService();
  GeoLocService geoLocService = new GeoLocService();
  Measurement_quizzlinesService measurement_quizzlinesService = new Measurement_quizzlinesService();

  bool initialization = false;
  Activity currentActivity;
  User currentUser;
  MeasurementModel currentMeasurementModel = MeasurementModel();
  MissionModel currentMissionModel = new MissionModel();

  List<AlternativeModel> listAlternativeModel = <AlternativeModel>[];
  List<MissionModel> listMissionModel = <MissionModel>[];

  final missionsController = MissionController(MissionService(Odoo()));

  final establishmentsController = EstablishmentController(EstablishmentService(Odoo()));

  init() async {
    if (initialization == true) return;

    listAlternativeModelLoad();
    missionsController.load();
    establishmentsController.load();

    listMissionModel = missionsController.missionsRequest.value;

    initialization = true;
  }

  void listAlternativeModelLoad() async {
    listAlternativeModel = await alternativeService.getAlternativeService();
  }

  Future<MeasurementModel> insert_MeasurementModel() async {
    geoLocService.update();

    MeasurementModel measurementModelInsert = MeasurementModel(
      id: null,
      mission_Id: 74,
      name: '//??-marcos',
      partner_Id: currentUser.partnerId,
      partner_Name: null,
      state: 'done',
      dateStarted: convertDateTimeToStringFormat(DateTime.now()),
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
    return measurementModelInserted;
  }

  Future<void> insert_Measurement_quizzlinesModel(AlternativeModel _selectedAlternativeModel) async {
    if (currentMeasurementModel == null) {
      currentMeasurementModel = await insert_MeasurementModel();
    }

    Measurement_quizzlinesModel measurement_quizzlinesModel = Measurement_quizzlinesModel(
        name: "//??-marcos",
        quizz_id: currentActivity.id,
        alternative_id: _selectedAlternativeModel.id,
        measurement_id: currentMeasurementModel.id,
        create_uid: currentUser.uid,
        write_uid: currentUser.uid);

    Measurement_quizzlinesModel measurement_quizzlinesModelInserted = await measurement_quizzlinesService.insertAndGet(measurement_quizzlinesModel);
    print(measurement_quizzlinesModelInserted);
  }

  setcurrentMissionModel(MissionModel missionModel) {
    //??-mateus
    //Se o usuário sair da tela de mensuração e retornar novamente, precisarei setar a mensuração em progresso.

    currentMissionModel = missionModel;
    currentMeasurementModel = null;
  }
}
