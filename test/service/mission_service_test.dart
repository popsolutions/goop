import 'package:flutter_test/flutter_test.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/AlternativeModel.dart';

import 'package:goop/models/login_dto.dart';
import 'package:goop/models/login_result.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurement_quizzlines.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/AlternativeService.dart';
import 'package:goop/services/Measurement_quizzlinesService.dart';
import 'package:goop/services/login/login_service.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/services/measurementService.dart';
import 'package:goop/services/mission/mission_service.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';

void main() {
  Odoo _odoo;
  bool isInit = false;
  MissionService missionService = new MissionService(Odoo());
  MeasurementService measurementService = new MeasurementService();
  UserServiceImpl userServiceImpl = new UserServiceImpl(Odoo());
  AlternativeService alternativeService = new AlternativeService();
  Measurement_quizzlinesService measurement_quizzlinesService =
      new Measurement_quizzlinesService();

  LoginResult currentLoginResult;
  User currentUser;

  void initLogin() async {
    LoginServiceImpl login = LoginServiceImpl(Odoo());
    LoginDto loginDto = LoginDto('support@popsolutions.co', '1ND1C0p4c1f1c0');

    currentLoginResult = await login.login(loginDto);
    currentUser =
        await userServiceImpl.getUserFromLoginResult(currentLoginResult);
  }

  void init() async {
    if (isInit) return;

    prefsGoop.init(true);

    await initLogin();

    isInit = true;
  }

  setUp(() {
    print('test Start');
  });

  setUpAll(() async {
    await init();
    print('Start all');
  });

  tearDown(() {
    print('test end');
  });

  tearDownAll(() {
    print('End All');
  });

  Future<List<MissionModel>> getMission() async {
    MissionService missionService = new MissionService(Odoo());
    List<MissionModel> listMissionModel = await missionService.getMissions();

    while (!missionService.getMissionsCompletLoad()){
      await Future.delayed(Duration(milliseconds: 60));
      print('Aguardando finalização de missionService.getMissions()');
    }

    await Future.delayed(Duration(milliseconds: 300));
    print('missionService.getMissions() Finalizado');

    return listMissionModel;
  }

  group('mission', () {
    test('missionService.getMissions', () async {
      List<MissionModel> listMissionModel = await getMission();
      print(listMissionModel.length.toString());
    });

    test('mission.update', () async {
      List<MissionModel> listMissionModel = await getMission();
      MissionModel missionModel = listMissionModel[3];
      print('::missionModel');

      missionModel.name = 'Missão 4';

      await missionService.updateMissionModel(missionModel);

      print(missionModel.toString());
    });
  });

  test('Measurement.getMeasurementModelById', () async {
    MeasurementModel measurementModel =
        await measurementService.getMeasurementModelById(140);
    print(JSONToStringWrapQuotClear(measurementModel.toJson()));
  });

  test('Measurement.insert', () async {
    MeasurementModel measurementModelInsert = MeasurementModel(
        id: null,
        mission_Id: 74,
        name: 'Teste Insert - vendor test-quizz',
        partner_Id: currentUser.partnerId,
        partner_Name: null,
        state: 'done',
        dateStarted: "2021-05-02",
        dateFinished: "2021-05-02",
        measurementLatitude: -23.561375671533103,
        measurementLongitude: -46.65641209735217,
        lines_ids: [],
        quizz_lines_ids: [],
        photo_lines_ids: [],
        price_comparison_lines_ids: [],
        color: 0,
        priority: "0",
        sequence: 10,
        active: true,
        kanbanState: "draft",
        legendPriority: false,
        legendBlocked: "Ready",
        legendDone: "Done",
        legendNormal: "Pending",
        legendDoing: "In Progress",
        create_Uid: currentUser.uid,
        create_Uname: null,
        createDate: "2021-05-31 21:10:12",
        write_Uid: currentUser.uid,
        write_Uname: null,
        writeDate: "2021-05-31 21:12:27",
        kanbanStateLabel: "Pending",
        displayName: "MEAS8-display name insert test",
        lastUpdate: null);

    MeasurementModel measurementModel =
        await measurementService.insertAndGet(measurementModelInsert);

    print(JSONToStringWrapQuotClear(measurementModel.toJson()));

    expect(measurementModel, isNotNull);
    print('INSERT OK!');
  });

  test('AlternativeService.listAlternativeModelLoad', () async {
    List<AlternativeModel> listAlternativeModel =
        await alternativeService.getAlternativeService();
    print('::listAlternativeModel');
    listAlternativeModel.forEach((element) {
      print(element.toJson());
    });
  });

  group('Measurement_quizzlinesModel', () {
    test('Measurement_quizzlinesModel.getMeasurement_quizzlinesModelModelById',
        () async {
      print(
          '::test Measurement_quizzlinesModel.getMeasurement_quizzlinesModelModelById');
      int id = 12;
      Measurement_quizzlinesModel measurement_quizzlinesModel =
          await measurement_quizzlinesService
              .getMeasurement_quizzlinesModelModelById(id);
      print(
          'Measurement_quizzlinesModel id $id : ${measurement_quizzlinesModel.toJson()}');
    });

    test('Measurement_quizzlinesModel.insertAndGet', () async {
      print('::test Measurement_quizzlinesModel.insertAndGet');
      Measurement_quizzlinesModel measurement_quizzlinesModel =
          Measurement_quizzlinesModel(
              name: "Nome-teste-insert",
              quizz_id: 50,
              alternative_id: 1,
              measurement_id: 151,
              create_uid: currentUser.uid,
              write_uid: currentUser.uid);

      Measurement_quizzlinesModel measurement_quizzlinesModelInserted =
          await measurement_quizzlinesService
              .insertAndGet(measurement_quizzlinesModel);

      expect(measurement_quizzlinesModel.quizz_id,
          equals(measurement_quizzlinesModelInserted.quizz_id));
      expect(measurement_quizzlinesModel.alternative_id,
          equals(measurement_quizzlinesModelInserted.alternative_id));
      expect(measurement_quizzlinesModel.measurement_id,
          equals(measurement_quizzlinesModelInserted.measurement_id));
      expect(measurement_quizzlinesModel.create_uid,
          equals(measurement_quizzlinesModelInserted.create_uid));
      expect(measurement_quizzlinesModel.write_uid,
          equals(measurement_quizzlinesModelInserted.write_uid));

      print(
          'Measurement_quizzlinesModel id ${measurement_quizzlinesModelInserted.id} : ${measurement_quizzlinesModelInserted.toJson()}');
    });
  });
}
