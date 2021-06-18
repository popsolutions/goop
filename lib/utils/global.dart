import 'package:goop/models/user.dart';
import 'package:goop/services/ServiceNotifier.dart';

import 'SharedPreferencesGoop.dart';

SharedPreferencesGoop prefsGoop = SharedPreferencesGoop();
User globalcurrentUser;
ServiceNotifier globalServiceNotifier;