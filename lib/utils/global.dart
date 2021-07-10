import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/GeoLocService.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'SharedPreferencesGoop.dart';
import 'StackUtil.dart';

SharedPreferencesGoop prefsGoop = SharedPreferencesGoop();
User globalcurrentUser;
ServiceNotifier globalServiceNotifier;
GeoLocService globalGeoLocService = GeoLocService();
GlobalConfig globalConfig = GlobalConfig();
StackUtil<String> globalScreenStack = StackUtil<String>();
bool globalDarMode = false;

const String globalLatitudeMocked = String.fromEnvironment('latitude', defaultValue: ''); //--dart-define=latitude=-22.4808083 --dart-define=longitude=-48.5619883
const String globalLongitudeMocked = String.fromEnvironment('longitude', defaultValue: '');

class GlobalConfig {
  double distanceMetersLimitUser = 200;
  int hoursDiffServer = -3;
  int hoursCompletMission = 3;
  int secondsRedMissionTime = 300;

  int gpsTimeOutSeconds1 = 15;
  int gpsTimeOutSeconds2 = 18;
}
