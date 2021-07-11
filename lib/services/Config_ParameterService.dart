import 'package:goop/models/config_parameter.dart';
import 'package:goop/services/absService.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';

import 'constants.dart';

class Config_ParameterService extends absService{
  final _prefixKey = 'MobileParams.';

  Future<List<Config_ParameterModel>> getMobileVariablesModel() async {
    final response = await odoo.searchRead(
      Strings.config_Parameter,
      [["key",
        "like",
        _prefixKey + '%']]
      ,
      [],
    );
    final List json = response.getRecords();
    final listConfig_ParameterModel = json.map((e) => Config_ParameterModel.fromJson(e)).toList();
    return listConfig_ParameterModel;
  }

  Future<void> setGlobalConfig() async {
    Log('Config_ParameterService.setGlobalConfig', 'Start');
    List<Config_ParameterModel> listConfig_ParameterModel;
    Config_ParameterModel currentConfig_ParameterModel;

    try {
      listConfig_ParameterModel = await getMobileVariablesModel();
    } catch(e) {
      Log('Config_ParameterService.setGlobalConfig', 'catch: ${e.toString()}');
      return;
    }

    bool findVar(String x_variable_name) {
      Log('Config_ParameterService.setGlobalConfig', 'findVar: $x_variable_name');

      currentConfig_ParameterModel = listConfig_ParameterModel.firstWhere((element) =>
      element.key.toUpperCase() == ('MobileParams.' + x_variable_name).toUpperCase(), orElse: () => null);

      if (currentConfig_ParameterModel == null)
        Log('Config_ParameterService.setGlobalConfig', 'findVar not found');
      else
        Log('Config_ParameterService.setGlobalConfig', 'findVar Sucess with value : "${currentConfig_ParameterModel.value}"');

      return currentConfig_ParameterModel != null;
    }

    if (findVar('distanceMetersLimitUser'))
      globalConfig.distanceMetersLimitUser = convertStringToDouble(currentConfig_ParameterModel.value);

    if (findVar('hoursDiffServer'))
      globalConfig.hoursDiffServer = convertStringToInt(currentConfig_ParameterModel.value);

    if (findVar('hoursCompletMission'))
      globalConfig.hoursCompletMission = convertStringToInt(currentConfig_ParameterModel.value);

    if (findVar('minutesCompletMission'))
      globalConfig.minutesCompletMission = convertStringToInt(currentConfig_ParameterModel.value);

    if (findVar('gpsTimeOutSeconds1'))
      globalConfig.gpsTimeOutSeconds1 = convertStringToInt(currentConfig_ParameterModel.value);

    if (findVar('gpsTimeOutSeconds2'))
      globalConfig.gpsTimeOutSeconds2 = convertStringToInt(currentConfig_ParameterModel.value);
  }

}