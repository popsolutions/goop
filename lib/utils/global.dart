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

class GlobalConfig {
  double distanceMetersLimitUser = 200;
  int hoursDiffServer = -3;
  int hoursCompletMission = 2;
  int secondsRedMissionTime = 300;
}
