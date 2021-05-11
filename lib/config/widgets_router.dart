import 'package:goop/config/routes.dart';
import 'package:goop/pages/home_page/home_page.dart';
import 'package:goop/pages/initial_page/initial_page.dart';
import 'package:goop/pages/login_page/login_page.dart';
import 'package:goop/pages/mission_page/mission_about_page.dart';
import 'package:goop/pages/mission_page/mission_completed_page.dart';
import 'package:goop/pages/mission_page/mission_home_page.dart';
import 'package:goop/pages/mission_page/mission_price_comparison_page.dart';
import 'package:goop/pages/mission_page/mission_questions_page.dart';
import 'package:goop/pages/recover_password_page/recover_password_page.dart';
import 'package:goop/pages/register_page/register_page.dart';
import 'package:goop/pages/settings_page/settings_page.dart';
import 'package:goop/pages/splash_page/splash_page.dart';
import 'package:goop/pages/splash_page/white_splash_page.dart';
import 'package:goop/pages/wallet_page/wallet_page.dart';

class WidgetsRouter {
  static final routes = {
    Routes.splash: (_) => SplashPage(),
    Routes.white_splash: (_) => WhiteSplashPage(),
    Routes.initial: (_) => InitialPage(),
    Routes.login: (_) => const LoginPage(),
    Routes.recover_password: (_) => RecoverPasswordPage(),
    Routes.register: (_) => RegisterPage(),
    Routes.home: (_) => HomePage(),
    Routes.settings: (_) => SettingsPage(),
    Routes.mission_completed: (_) => MissionCompletedPage(),
    Routes.mission_home: (_) => MissionHomePage(),
    Routes.mission_about: (_) => MissionAboutPage(),
    Routes.mission_price_comparison: (_) => MissionPriceComparisionPage(),
    Routes.mission_question: (_) => MissionQuestionPage(),
    Routes.wallet: (_) => WalletPage(),
  };
}
