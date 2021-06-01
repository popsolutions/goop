import 'package:flutter/cupertino.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/pages/mission_page/mission_controller.dart';
import 'package:goop/services/mission/mission_service.dart';

class MissionProvider extends ChangeNotifier {
  final missionsController = MissionController(MissionService(Odoo()));
}
