import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/GeoLocService.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/utils.dart';
import 'SharedPreferencesGoop.dart';
import 'StackUtil.dart';
import 'package:flutter/services.dart' as rootBundle;

SharedPreferencesGoop prefsGoop = SharedPreferencesGoop();
User globalcurrentUser;
ServiceNotifier globalServiceNotifier;
GeoLocService globalGeoLocService = GeoLocService();
GlobalConfig globalConfig = GlobalConfig();
StackUtil<String> globalScreenStack = StackUtil<String>();
GoopColors goopColors = GoopColors();
Function globalRebuildAllChildren;

const String globalConfJson = String.fromEnvironment('conf', defaultValue: ''); //--dart-define=conf=dev_charisma1

class GlobalConfig {
  String confJsonPath = 'assets/jsons/conf.json';

  String dbName = '';
  String serverURL = '';
  String userOdoo = '';
  String pass = '';
  String alertaApp = '';
  
  get serverURLRegisterPage => serverURL + '/web/signup';

  bool darkMode = false;

  //variables that can be configured in Odoo "ir.config_parameter" module with "MobileGoopParams." prefix.
  //For example "distanceMetersLimit" should be set to "MobileGoopParams..distanceMetersLimitUser"
  double distanceMetersLimitUser = 200;
  int hoursDiffServer = 0;
  int hoursCompletMission = 3;
  int minutesCompletMission = 0;
  int secondsRedMissionTime = 300;

  int gpsTimeOutSeconds1 = 15;
  int gpsTimeOutSeconds2 = 18;

  double LatitudeMocked;
  double LongitudeMocked;

  bool devMode = false;


  //###################

  void readconfJson() async {
    //### Esta rotina irá carregar as variáveis padrões de acordo com as configurações estabelecidas em "assets/jsons/conf.json"
    if (globalConfJson != '') {
      var jsonFile;
      var json;

      try {
        jsonFile = await rootBundle.rootBundle.loadString(confJsonPath);
      } catch (e) {
        throw 'Foi definido "--dart-define=conf=" porém não foi encontrado o Arquivo "$confJsonPath".';
      }

      try {
        json = jsonDecode(jsonFile);
      } catch (e) {
        throw 'Foi definido "--dart-define=conf=" porém o Arquivo "$confJsonPath" não parece um Json válido.' + e.toString();
      }
      var conf = json[globalConfJson];

      throwIf(
          conf == null, 'Configuração "$globalConfJson" definida em "--dart-define=conf=" não foi encontrada no arquivo "$confJsonPath"');

      serverURL = conf['serverURL'];
      dbName = conf['dbName'];
      userOdoo = conf['userOdoo'];
      pass = conf['pass'];
      hoursDiffServer = conf['hoursDiffServer'];
      LatitudeMocked = conf['LatitudeMocked'];
      LongitudeMocked = conf['LongitudeMocked'];
      devMode = conf['devMode'] ?? false;
      alertaApp = conf['alertaApp'];
    }
  }
}
