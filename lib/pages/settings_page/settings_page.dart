import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_alert.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

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
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          GoopImages.avatar,
                          height: 150,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Marília',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: GoopColors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GoopTextFormField(hintText: 'E-mail'),
                GoopTextFormField(hintText: 'Celular'),
                GoopTextFormField(hintText: 'PIX'),
                SizedBox(height: 15),
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => GoopAlert(
                        title: 'Termos de Uso',
                        contet: '''
          Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa. Fusce posuere, magna sed pulvinar ultricies, purus lectus malesuada libero, sit amet commodo magna eros quis urna.
          Nunc viverra imperdiet enim. Fusce est. Vivamus a tellus.
          Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin pharetra nonummy pede. Mauris et orci.
          Aenean nec lorem. In porttitor. Donec laoreet nonummy augue.
          Suspendisse dui purus, scelerisque at, vulputate vitae, pretium mattis, nunc. Mauris eget neque at sem venenatis eleifend. Ut nonummy.
          Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Maecenas porttitor congue massa.
''',
                      ),
                    );
                  },
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
