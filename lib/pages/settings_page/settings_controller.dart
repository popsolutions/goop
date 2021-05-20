import 'package:goop/models/update_user.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/utils/validators.dart';
import 'package:mobx/mobx.dart';
part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  final UserServiceImpl _userService;

  _SettingsControllerBase(this._userService);

  int _id;
  set id(int newId) => _id = newId;

  @observable
  String email = '';

  @observable
  String phone = '';

  @observable
  String cpf = '';

  @computed
  bool get isLoading => _updateRequest.status == FutureStatus.pending;

  @computed
  bool get canNext =>
      Validators.validateEmail(email) == null &&
      Validators.validatePhone(phone) == null &&
      Validators.validateCPF(cpf) == null;

  @observable
  ObservableFuture _updateRequest = ObservableFuture.value(null);

  ObservableFuture get updateRequest => _updateRequest;

  @action
  void submit() {
    _updateRequest = _userService
        .update(
          UpdateUser(
            partnerId: _id,
            email: email,
            cnpjCpf: cpf,
            phone: phone,
          ),
        )
        .asObservable();
  }
}
