import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_images.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';

class RecoverPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle style(double fontSize) {
      return TextStyle(
        fontFamily: 'RobotoCondensed',
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: SvgPicture.asset(GoopImages.recover_password),
                ),
                Text(
                  'Recuperar Senha',
                  style: style(25),
                ),
                Text(
                  'Por Favor, digite o seu e-mail abaixo',
                  style: style(18),
                ),
                SizedBox(height: 30),
                GoopTextFormField(hintText: "E-mail"),
                GoopButton(
                  text: 'Enviar',
                  action: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
