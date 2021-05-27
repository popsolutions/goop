import 'package:goop/models/mission.dart';
import 'package:goop/services/mission/mission_service.dart';
import 'package:mobx/mobx.dart';
part 'mission_controller.g.dart';

class MissionController = _MissionControllerBase with _$MissionController;

abstract class _MissionControllerBase with Store {
  final MissionService _missionService;

  _MissionControllerBase(this._missionService);

  @observable
  ObservableFuture<List<MissionModel>> _missionsRequest =
      ObservableFuture.value(null);

  ObservableFuture<List<MissionModel>> get missionsRequest => _missionsRequest;

  @action
  void load() {
    _missionsRequest = _missionService.getMissions().asObservable();
  }
}
