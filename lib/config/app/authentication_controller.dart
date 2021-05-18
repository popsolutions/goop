import 'package:goop/models/user.dart';
import 'package:mobx/mobx.dart';
part 'authentication_controller.g.dart';

class AuthenticationController = _AuthenticationControllerBase
    with _$AuthenticationController;

abstract class _AuthenticationControllerBase with Store {
  @observable
  User _currentUser;

  User get currentUser => _currentUser;

  @computed
  bool get isAuthenticated => _currentUser != null;

  @action
  void authenticate(User user) {
    _currentUser = user;
  }

  @action
  void logout() {
    _currentUser = null;
  }
}
