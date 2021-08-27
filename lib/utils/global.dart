import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/GeoLocService.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_colors.dart';
import 'SharedPreferencesGoop.dart';
import 'StackUtil.dart';

SharedPreferencesGoop prefsGoop = SharedPreferencesGoop();
User globalcurrentUser;
ServiceNotifier globalServiceNotifier;
GeoLocService globalGeoLocService = GeoLocService();
GlobalConfig globalConfig = GlobalConfig();
StackUtil<String> globalScreenStack = StackUtil<String>();
GoopColors goopColors = GoopColors();
Function globalRebuildAllChildren;

const String globalLatitudeMocked = String.fromEnvironment('latitude', defaultValue: ''); //--dart-define=latitude=-22.4808083 --dart-define=longitude=-48.5619883
const String globalLongitudeMocked = String.fromEnvironment('longitude', defaultValue: '');

final String _serverURL = 'https://charismabi.com.br';

class GlobalConfig {
  String dbName = 'charisma-prod';
  String serverURL = _serverURL;
  String userOdoo = '';
  String pass = '';
  String serverURLRegisterPage = _serverURL + '/web/signup';

  // String dbName = 'odoo_mateus';
  // String serverURL = 'http://192.168.0.55:8069';
  // String userOdoo = 'mateus.2006@gmail.com';
  // String pass = 'mateus';

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
}
