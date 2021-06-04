import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/AlternativeModel.dart';

import 'package:goop/models/login_dto.dart';
import 'package:goop/models/login_result.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/AlternativeService.dart';
import 'package:goop/services/login/login_service.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/services/measurementService.dart';
import 'package:goop/services/mission/mission_service.dart';
import 'package:goop/utils/utils.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

void main() {
  // Odoo _odoo ;
  bool isInit = false;
  MissionService missionService = new MissionService();
  MeasurementService measurementService = new MeasurementService();
  UserServiceImpl userServiceImpl = new UserServiceImpl(Odoo());
  AlternativeService alternativeService = new AlternativeService();

  LoginResult currentLoginResult;
  User currentUser;

  void init() async {
    if (isInit) return;

    const String _key = Constants.SESSION;
    const String _prefixedKey = 'flutter.' + _key;
    SharedPreferences.setMockInitialValues(<String, dynamic>{_prefixedKey: ''});

    LoginServiceImpl login = LoginServiceImpl(Odoo());
    LoginDto loginDto = LoginDto('support@popsolutions.co', '1ND1C0p4c1f1c0');

    currentLoginResult = await login.login(loginDto);
    currentUser = await userServiceImpl.getUserFromLoginResult(currentLoginResult);
    isInit = true;
  }

  Future<List<MissionModel>> getMission() async {
    await init();
    MissionService missionService = new MissionService();
    List<MissionModel> listMissionModel = await missionService.getMissions();
    return listMissionModel;
  }

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

  test('Measurement.getMeasurementModelById', () async {
    await init();
    MeasurementModel measurementModel = await measurementService.getMeasurementModelById(140);
    print(JSONToStringWrapQuotClear(measurementModel.toJson()));
  });

  test('Measurement.insert', () async {
    await init();
    MeasurementModel measurementModelInsert = MeasurementModel(
        id: null,
        mission_Id: 74,
        name: 'Teste Insert - vendor test-Pedro',
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
        lastUpdate: null
    );

    MeasurementModel measurementModel = await measurementService.insertAndGet(measurementModelInsert);

    print(JSONToStringWrapQuotClear(measurementModel.toJson()));

    expect(measurementModel, isNotNull);
    print('INSERT OK!');
  });

  test('AlternativeService.listAlternativeModelLoad', () async{
    await init();
    List<AlternativeModel> listAlternativeModel = await alternativeService.getAlternativeService();
    print('::listAlternativeModel');
    listAlternativeModel.forEach((element) {print(element.toJson());});

  });

}
