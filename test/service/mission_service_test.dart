import 'package:flutter_test/flutter_test.dart';
import 'package:goop/config/http/odoo_api.dart';

import 'package:goop/models/login_dto.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/services/login/login_service.dart';
import 'package:goop/services/mission/mission_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  bool isInit = false;

  void init() async {
    if (isInit) return;

    const String _key = Constants.SESSION;
    const String _prefixedKey = 'flutter.' + _key;
    SharedPreferences.setMockInitialValues(<String, dynamic>{_prefixedKey: ''});

    LoginServiceImpl login = LoginServiceImpl(Odoo());
    LoginDto loginDto = LoginDto('support@popsolutions.co', '1ND1C0p4c1f1c0');

    await login.login(loginDto);
    isInit = true;
  }

  Future<List<MissionModel>> getMission() async {
    await init();
    MissionService missionService = new MissionService(Odoo());
    List<MissionModel> listMissionModel =  await missionService.getMissions();
    return listMissionModel;
  }

  test('missionService.getMissions', () async {
    List<MissionModel> listMissionModel = await getMission();
    print(listMissionModel.length.toString());
  });
}
