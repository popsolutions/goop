import 'package:goop/models/AlternativeModel.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/AlternativeService.dart';

import '../config/http/odoo_api.dart';
import '../pages/mission_page/mission_controller.dart';
import 'establishment/establishment_controller.dart';
import 'establishment/establishment_service.dart';
import 'mission/mission_service.dart';

class ServiceNotifier {
  //ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);
  AlternativeService alternativeService = new AlternativeService();

  bool initialization = false;
  Activity currentActivity;
  User currentUser;
  List<AlternativeModel> listAlternativeModel = <AlternativeModel>[];
  final missionsController = MissionController(MissionService(Odoo()));

  final establishmentsController =
      EstablishmentController(EstablishmentService(Odoo()));

  init() async {
    if (initialization == true) return;

    listAlternativeModelLoad();
    missionsController.load();
    establishmentsController.load();
    initialization = true;
  }

  void listAlternativeModelLoad() async {
    listAlternativeModel = await alternativeService.getAlternativeService();
  }
}
