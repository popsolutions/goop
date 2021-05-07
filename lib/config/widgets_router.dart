import 'package:goop/config/routes.dart';
import 'package:goop/pages/home/home_page.dart';
import 'package:goop/pages/initial/initial_page.dart';
import 'package:goop/pages/login/login_page.dart';
import 'package:goop/pages/mission/mission_completed_page.dart';
import 'package:goop/pages/recover_password/recover_password_page.dart';
import 'package:goop/pages/register/register_page.dart';
import 'package:goop/pages/settings/settings_page.dart';
import 'package:goop/pages/splash/splash_page.dart';

class WidgetsRouter {
  static final routes = {
    Routes.splash: (_) => SplashPage(),
    Routes.initial: (_) => InitialPage(),
    Routes.login: (_) => const LoginPage(),
    Routes.recover_password: (_) => RecoverPasswordPage(),
    Routes.register: (_) => RegisterPage(),
    Routes.home: (_) => HomePage(),
    Routes.settings: (_) => SettingsPage(),
    Routes.mission_completed: (_) => MissionCompletedPage(),
  };
}
