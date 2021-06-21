import 'package:flutter_test/flutter_test.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/AlternativeModel.dart';

import 'package:goop/models/login_dto.dart';
import 'package:goop/models/login_result.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurementPhotoLines.dart';
import 'package:goop/models/measurementPriceComparisonLines.dart';
import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/AlternativeService.dart';
import 'package:goop/services/MeasurementPhotoLinesService.dart';
import 'package:goop/services/MeasurementQuizzlinesService.dart';
import 'package:goop/services/QuizzLinesModelService.dart';
import 'package:goop/services/login/login_service.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/services/measurementPriceComparisonLinesService.dart';
import 'package:goop/services/measurementService.dart';
import 'package:goop/services/mission/mission_service.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';

void main() {
  bool isInit = false;
  String imageEmotionBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=';
  MissionService missionService = new MissionService(Odoo());
  MeasurementService measurementService = new MeasurementService();
  UserServiceImpl userServiceImpl = new UserServiceImpl(Odoo());
  AlternativeService alternativeService = new AlternativeService();
  MeasurementQuizzlinesService measurementQuizzlinesService =
      new MeasurementQuizzlinesService();

  QuizzLinesModelService quizzLinesModelService = new QuizzLinesModelService();
  MeasurementPhotoLinesService measurementPhotoLinesService =
      new MeasurementPhotoLinesService();
  MeasurementPriceComparisonLinesService
      measurementPriceComparisonLinesService =
      new MeasurementPriceComparisonLinesService();

  LoginResult currentLoginResult;
  User currentUser;

  void initLogin() async {
    LoginServiceImpl login = LoginServiceImpl(Odoo());
    LoginDto loginDto = LoginDto('support@popsolutions.co', '1ND1C0p4c1f1c0');

    currentLoginResult = await login.login(loginDto);
    currentUser =
        await userServiceImpl.getUserFromLoginResult(currentLoginResult);
    globalcurrentUser = currentUser;
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
    List<MissionModel> listMissionModel =
        await missionService.getOpenMissions();

    while (!missionService.getMissionsCompletLoad()) {
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

  group('mission_service', () {
    test('MissionService.getListActivity', () async {
      MissionService missionService = new MissionService(Odoo());
      MissionModel missionModel = await missionService.getMissionById(79);
      print(missionModel.toJson());

      await missionService.setListActivity(missionModel, currentUser);

      print(missionModel.listActivity.length);
    });
  });

  test('Measurement.getMeasurementModelById', () async {
    MeasurementModel measurementModel =
        await measurementService.getMeasurementModelById(219);
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
        dateStarted: DateTime.now(),
        dateFinished: null,
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
        // createDate: "2021-05-31 21:10:12",
        write_Uid: currentUser.uid,
        write_Uname: null,
        // writeDate: "2021-05-31 21:12:27",
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
      MeasurementQuizzlinesModel measurement_quizzlinesModel =
          await measurementQuizzlinesService
              .getMeasurement_quizzlinesModelModelById(id);
      print(
          'Measurement_quizzlinesModel id $id : ${measurement_quizzlinesModel.toJson()}');
    });

    test('Measurement_quizzlinesModel.insertAndGet', () async {
      print('::test Measurement_quizzlinesModel.insertAndGet');
      MeasurementQuizzlinesModel measurement_quizzlinesModel =
          MeasurementQuizzlinesModel(
              name: "Nome-teste-insert",
              quizz_id: 50,
              alternative_id: 1,
              measurement_id: 151,
              create_uid: currentUser.uid,
              write_uid: currentUser.uid);

      MeasurementQuizzlinesModel measurement_quizzlinesModelInserted =
          await measurementQuizzlinesService
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

  test('QuizzLinesModelService.getQuizzLinesModelFromQuizz', () async {
    List<QuizzLinesModel> quizzLinesModel =
        await quizzLinesModelService.getQuizzLinesModelFromQuizz(45);

    print(quizzLinesModel.length);
  });

  test('MeasurementService.getMeasurementModelFromMissionIdAndPartner_id',
      () async {
    MeasurementModel measurementModel = await measurementService
        .getMeasurementModelFromMissionIdAndPartner_id(79, 3);
    print(measurementModel.toJson());
  });

  test('MeasurementQuizzLinesService.getMeasurement_quizzlinesModelModelById',
      () async {
    MeasurementQuizzlinesModel listMeasurementQuizzlinesModel =
        await measurementQuizzlinesService
            .getMeasurementQuizzLinesFromMeasurementIdAndQuizLinesId(191, 56);
    print(listMeasurementQuizzlinesModel.toJson());
  });

  test('MeasurementPhotoLinesService.insertAndGet', () async {
    MeasurementPhotoLinesModel measurementPhotoLinesModel =
        MeasurementPhotoLinesModel(
            measurement_id: 214,
            name: 'Teste Flutter',
            photo: imageEmotionBase64,
            photo_id: 101,
            create_uid: currentUser.uid,
            write_uid: currentUser.uid);

    MeasurementPhotoLinesModel measurementPhotoLinesModelInserted =
        await measurementPhotoLinesService
            .insertAndGet(measurementPhotoLinesModel);
    print(measurementPhotoLinesModelInserted.toJson());
  });

  test('MeasurementPhotoLinesService.getMeasurementPhotoLinesModelModelById',
      () async {
    MeasurementPhotoLinesModel measurementPhotoLinesModel =
        await measurementPhotoLinesService
            .getMeasurementPhotoLinesModelById(53);
    print(measurementPhotoLinesModel.toJson());
  });

  test(
      'MeasurementPriceComparisonLinesService.getMeasurementPriceComparisonLinesModel',
      () async {
    MeasurementPriceComparisonLinesModel measurementPriceComparisonLinesModel =
        await measurementPriceComparisonLinesService
            .getMeasurementPriceComparisonLinesModel(104);
    print(measurementPriceComparisonLinesModel.toJson());
  });

  test('MeasurementPriceComparisonLinesService.insertAndGet', () async {
    MeasurementPriceComparisonLinesModel measurementPriceComparisonLinesModel =
        MeasurementPriceComparisonLinesModel(
      measurement_id: 224,
      product_id: 4,
      price: 777,
      photo: imageEmotionBase64,
      create_uid: currentUser.uid,
      // create_date:,
      write_uid: currentUser.uid,
      // write_date:,
      // display_name:,
    );

    MeasurementPriceComparisonLinesModel
        measurementPriceComparisonLinesModelInserted =
        await measurementPriceComparisonLinesService
            .insertAndGet(measurementPriceComparisonLinesModel);
    print(measurementPriceComparisonLinesModelInserted.toJson());
  });
}
