
import 'package:goop/models/mobileVariables.dart';
import 'package:goop/services/absService.dart';
import 'package:goop/services/constants.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';

class MobileVariablesService extends absService {

  Future<List<MobileVariablesModel>> getMobileVariablesModel([int id]) async {
    List domain = [];

    if (id != null)
      domain = [['id', '=', id.toString()]];

    final response = await odoo.searchRead(
      Strings.mobileVariables,
      domain
      ,
      [],
    );
    final List json = response.getRecords();
    final listMobileVariablesModel = json.map((e) => MobileVariablesModel.fromJson(e)).toList();
    return listMobileVariablesModel;
  }

  Future<MobileVariablesModel> getMobileVariablesModelById([int id]) async {
    List<MobileVariablesModel> listMobileVariablesModel = await getMobileVariablesModel(id);

    if (listMobileVariablesModel == null)
      return null;
    else
      return listMobileVariablesModel[0];
  }

  void update(MobileVariablesModel mobileVariablesModel) async {
    await odoo.write(
      Strings.missions,
      [mobileVariablesModel.id],
      mobileVariablesModel.toJson(),
    );
  }

  Future<MobileVariablesModel> insertAndGet(MobileVariablesModel mobileVariablesModel) async {
    int id = await insert(mobileVariablesModel);
    MobileVariablesModel mobileVariablesModelInserted = await getMobileVariablesModelById(id);
    return mobileVariablesModelInserted;
  }

  Future<int> insert(MobileVariablesModel mobileVariablesModel) async {
    final response = await odoo.create(mobileVariablesModel.modelName, mobileVariablesModel.toJson());

    if (response.getStatusCode() == 200){
      return response.getResult(); //return id
    } else {
      throw 'MobileVariablesModel Insert fail';
    }
  }

  Future<void> setGlobalConfig() async {
    Log('MobileVariablesService.setGlobalConfig', 'Start');
    List<MobileVariablesModel> listMobileVariablesModel;
    MobileVariablesModel currentMobileVariablesModel;

    try {
      listMobileVariablesModel = await getMobileVariablesModel();
    } catch(e) {
      Log('MobileVariablesService.setGlobalConfig', 'catch: ${e.toString()}');
      return;
    }

    bool findVar(String x_variable_name) {
      Log('MobileVariablesService.setGlobalConfig', 'findVar: $x_variable_name');

      currentMobileVariablesModel = listMobileVariablesModel.firstWhere((element) =>
          element.x_variable_name.toUpperCase() == x_variable_name.toUpperCase(), orElse: () => null);

      if (currentMobileVariablesModel == null)
        Log('MobileVariablesService.setGlobalConfig', 'findVar not found');
      else
        Log('MobileVariablesService.setGlobalConfig', 'findVar Sucess with value : "${currentMobileVariablesModel.x_variable_value}"');

      return currentMobileVariablesModel != null;
    }

    if (findVar('distanceMetersLimitUser'))
      globalConfig.distanceMetersLimitUser = convertStringToDouble(currentMobileVariablesModel.x_variable_value);

    if (findVar('hoursDiffServer'))
      globalConfig.hoursDiffServer = convertStringToInt(currentMobileVariablesModel.x_variable_value);

    if (findVar('hoursCompletMission'))
      globalConfig.hoursCompletMission = convertStringToInt(currentMobileVariablesModel.x_variable_value);

    if (findVar('minutesCompletMission'))
      globalConfig.minutesCompletMission = convertStringToInt(currentMobileVariablesModel.x_variable_value);

    if (findVar('gpsTimeOutSeconds1'))
      globalConfig.gpsTimeOutSeconds1 = convertStringToInt(currentMobileVariablesModel.x_variable_value);

    if (findVar('gpsTimeOutSeconds2'))
      globalConfig.gpsTimeOutSeconds2 = convertStringToInt(currentMobileVariablesModel.x_variable_value);
  }
}