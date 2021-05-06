import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_colors.dart';
import 'package:goop/pages/components/goop_images.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                    hintText: "E-mail",
                  ),
                  GoopTextFormField(
                    hintText: "Senha",
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
                      Navigator.pushNamed(
                        context,
                        Routes.recover_password,
                      );
                    },
                  ),
                  GoopButton(
                    text: 'Entrar',
                    action: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.home,
                        (route) => false,
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
