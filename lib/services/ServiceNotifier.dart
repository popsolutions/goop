import 'package:flutter/cupertino.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/models/AlternativeModel.dart';
import 'package:goop/models/accountInvoice.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurementPhotoLines.dart';
import 'package:goop/models/measurementPriceComparisonLines.dart';
import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/models.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/models/user.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/services/AccountInvoiceService.dart';
import 'package:goop/services/ActivityService.dart';
import 'package:goop/services/AlternativeService.dart';
import 'package:goop/services/Config_ParameterService.dart';
import 'package:goop/services/GeoLocService.dart';
import 'package:goop/services/MeasurementExecutedsService.dart';
import 'package:goop/services/MeasurementPhotoLinesService.dart';
import 'package:goop/services/MeasurementQuizzlinesService.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';
import '../config/http/odoo_api.dart';
import 'establishment/establishment_controller.dart';
import 'establishment/establishment_service.dart';
import 'measurementPriceComparisonLinesService.dart';
import 'measurementService.dart';
import 'mission/mission_service.dart';

class ServiceNotifier extends ChangeNotifier {
  // ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);

  bool _geoLocationOk = false;
  BuildContext currentBuildContext;
  AlternativeService alternativeService = new AlternativeService();
  MeasurementService measurementService = new MeasurementService();
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
  MeasurementExecutedsService measurementExecutedsService = MeasurementExecutedsService();
  AccountInvoiceService accountInvoiceService = new AccountInvoiceService();
  Config_ParameterService config_parameterService = new Config_ParameterService();


  bool initialization = false;
  Activity currentActivity;
  User currentUser;
  MissionModel currentMissionModel = new MissionModel();
  MissionModelEstablishment currentMissionModelEstablishment;
  bool isLoading = false;

  List<AlternativeModel> listAlternativeModel = <AlternativeModel>[];
  List<MissionModel> listMissionModel = <MissionModel>[];
  List<MissionModelEstablishment> listMissionModelEstablishment =
      <MissionModelEstablishment>[];

  bool viewByEstablishment = false;

  final establishmentsController =
      EstablishmentController(EstablishmentService(Odoo()));

  Future<void> init([BuildContext context = null]) async {
    if (initialization == true) return;

    globalServiceNotifier = this;
    try {
      await update(context);
    }catch(e){
      goop_LibComponents.showMessage(context, 'Erro na inicialização', e.toString());
    }
    initialization = true;
  }

  Future<void> close([BuildContext context = null]) async {
    initialization = false;
  }

  update([BuildContext context = null]) async {
    await listAlternativeModelLoad();
    await config_parameterService.setGlobalConfig();
    listMissionModel = await missionService.getOpenMissions();
    listMissionModelEstablishment =
        await missionService.getListMissionModelEstablishment(listMissionModel);

    if (currentMissionModelEstablishment != null){
      currentMissionModelEstablishment = listMissionModelEstablishmentGetById(currentMissionModelEstablishment.establishmentModel.id);
    }

    await globalGeoLocService.update(context);
    notifyListeners();
  }

  MissionModelEstablishment listMissionModelEstablishmentGetById(int id){
    return listMissionModelEstablishment.firstWhere((element) => element.establishmentModel.id == id, orElse: () => null);
  }

  void listAlternativeModelLoad() async {
    listAlternativeModel = await alternativeService.getAlternativeService();
  }

  Future<void> insert_Measurement_quizzlinesModel(
      QuizzLinesModel _selectedQuizzLinesModel) async {
    await createOrUpdateGeoLocMeasurementModel();

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

    await missionAfterActivityExec();
  }

  Future<void> createOrUpdateGeoLocMeasurementModel([BuildContext context]) async {
    // await delayedSeconds(4);
    if (currentMissionModel.measurementModel == null) {
      await missionService.createMeasurementModel(
          currentMissionModel, currentUser);
    } else {
      await measurementService.updateGeoLocation(currentMissionModel.measurementModel, currentMissionModel, context);
    }
  }

  Future<void> insert_Measurement_photolines(String photoBase64, BuildContext context) async {
    await createOrUpdateGeoLocMeasurementModel(context);

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

    await missionAfterActivityExec();
  }

  Future<void> insert_Measurement_PriceComparisonLinesModel(
      double price, String photoBase64) async {
    await createOrUpdateGeoLocMeasurementModel();

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

    await missionAfterActivityExec();
  }

  Future<void> missionAfterActivityExec(){
    currentMissionModel.updateStatus();
    notifyListeners();
  }

  Future<void> measurementDone(BuildContext context) async {
    if (currentMissionModel.status != MissionStatus.Done)
      throw 'Status inválido da missão';

    MeasurementModel measurementModel = currentMissionModel.measurementModel;
    measurementModel.state = 'done';
    measurementService.updateGeoLocation(measurementModel, currentMissionModel, context);
    missionAfterActivityExec();
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

  Future<List<AccountInvoiceModel>> getAccountInvoicesCurrentUser() async => await accountInvoiceService.getAccountInvoiceModelCurrentUser();

  bool get geoLocationOk => _geoLocationOk;

  set geoLocationOk(bool value) {
    bool oldValue = _geoLocationOk;
    _geoLocationOk = value;
    if (oldValue != value)
      notifyListeners();
  }

  List<MissionModel> getlistMissionModelDistinct = <MissionModel>[];
}
