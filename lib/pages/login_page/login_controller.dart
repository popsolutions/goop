import 'package:goop/models/login_dto.dart';
import 'package:goop/services/login/login_facade_impl.dart';
import 'package:mobx/mobx.dart';

import '../../models/user.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final LoginFacade _loginFacade;

  _LoginControllerBase(this._loginFacade);

  @observable
  ObservableFuture<User> loginRequest = ObservableFuture.value(null);
  @observable
  String login = '';
  @observable
  String password = '';

  @computed
  bool get canNext => login.isNotEmpty && password.isNotEmpty;
  @computed
  bool get isLoading => loginRequest.status == FutureStatus.pending;

  @action
  void submit() {
    loginRequest = _loginFacade
        .login(LoginDto(
          login.trim(),
          password.trim(),
        ))
        .asObservable();
  }
}
