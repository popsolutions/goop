import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_colors.dart';
import 'package:goop/pages/components/goop_images.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';

class SettingsPage extends StatelessWidget {
  style() {
    return TextStyle(
      fontSize: 15,
      decoration: TextDecoration.underline,
      color: GoopColors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: SvgPicture.asset(
                      GoopImages.avatar,
                      height: 150,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                GoopTextFormField(hintText: 'E-mail'),
                GoopTextFormField(hintText: 'Celular'),
                GoopTextFormField(hintText: 'PIX'),
                TextButton(
                  child: Text(
                    'Sobre o GoOp',
                    style: style(),
                  ),
                  onPressed: () {},
                ),
                TextButton(
                  child: Text(
                    'Termos de Uso',
                    style: style(),
                  ),
                  onPressed: () {},
                ),
                TextButton(
                  child: Text(
                    'Desativar minha conta',
                    style: style(),
                  ),
                  onPressed: () {},
                ),
                Center(
                  child: GoopButton(
                    text: 'Salvar',
                    action: () {},
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
