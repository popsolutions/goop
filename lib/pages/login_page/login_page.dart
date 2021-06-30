import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/pages/login_page/login_controller.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/services/login/login_service.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/services/login/login_facade_impl.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateGoop<LoginPage> {
  ServiceNotifier serviceNotifier;
  AuthenticationController _authenticationController;
  LoginController _loginController;
  ReactionDisposer _loginReaction;

  @override
  void initState() {
    final odoo = Odoo();
    _loginController = LoginController(
      LoginFacade(
        LoginServiceImpl(odoo),
        UserServiceImpl(odoo),
      ),
    );
    _loginReaction =
        reaction((_) => _loginController.loginRequest.status, _onLoginRequest);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context, listen: false);
    _authenticationController = serviceNotifier.authenticationController;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _loginReaction();
    super.dispose();
  }

  void _onLoginRequest(FutureStatus status) {
    switch (status) {
      case FutureStatus.fulfilled:
        _onSuccess();
        break;
      case FutureStatus.rejected:
        _onError();
        break;
      default:
    }
  }

  void _onSuccess() {
    final user = _loginController.loginRequest.value;
    serviceNotifier.setCurrentUser(user);

    _authenticationController.authenticate(user);
    pushNamedAndRemoveUntil(
      Routes.home,
      (route) => false,
    );
  }

  void _onError() {
    showMessage('Opss', 'Usuário ou senha inválidos');
  }

  @override
  Widget build(BuildContext context) {
    serviceNotifier = Provider.of<ServiceNotifier>(context, listen: false);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GoopBack(),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    height: 190,
                    child: SvgPicture.asset(GoopImages.login),
                  ),
                  GoopTextFormField(
                    initialValue: _loginController.login,
                    hintText: "E-mail",
                    onChanged: (e) => _loginController.login = e,
                  ),
                  GoopTextFormField(
                    initialValue: _loginController.password,
                    hintText: "Senha",
                    onChanged: (e) => _loginController.password = e,
                    obscureText: true,
                  ),
                  TextButton(
                    child: Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: GoopColors.darkBlue,
                      ),
                    ),
                    onPressed: () {
                      navigatorPushNamed(
                        Routes.recover_password,
                      );
                    },
                  ),
                  Observer(
                    builder: (_) {
                      return GoopButton(
                        isLoading: _loginController.isLoading,
                        text: 'Entrar',
                        action: _loginController.canNext
                            ? _loginController.submit
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
