import '../../models/login_dto.dart';
import '../../models/user.dart';
import './login_service.dart';
import './user_service.dart';

class LoginFacade {
  final LoginServiceImpl _loginService;
  final UserServiceImpl _userService;

  LoginFacade(this._loginService, this._userService);

  Future<User> login(LoginDto loginDto) async {
    final loginResponse = await _loginService.login(loginDto);

    return _userService.getUserFromLoginResult(loginResponse);
  }
}
