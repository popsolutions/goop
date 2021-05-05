import 'package:goop/config/routes.dart';
import 'package:goop/pages/initial/initial_page.dart';
import 'package:goop/pages/login/login_page.dart';
import 'package:goop/pages/recover_password/recover_password_page.dart';
import 'package:goop/pages/register/register_page.dart';
import 'package:goop/pages/splash/splash_page.dart';

class WidgetsRouter {
  static final routes = {
    Routes.splash: (context) => SplashPage(),
    Routes.initial: (context) => InitialPage(),
    Routes.login: (context) => const LoginPage(),
    Routes.recover_password: (context) => RecoverPasswordPage(),
    Routes.register: (context) => RegisterPage(),
  };
}
