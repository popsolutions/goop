import 'package:flutter/material.dart';

import '../config/http/odoo_api.dart';
import '../pages/mission_page/mission_controller.dart';
import 'establishment/establishment_controller.dart';
import 'establishment/establishment_service.dart';
import 'mission/mission_service.dart';

class ServiceNotifier {
  bool initialization = false;

  final missionsController = MissionController(MissionService(Odoo()));

  final establishmentsController = EstablishmentController(EstablishmentService(Odoo()));

  init() async {
    if (initialization == true) return;

    missionsController.load();
    establishmentsController.load();
    initialization = true;

  }

}