import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_colors.dart';
import 'package:goop/pages/components/goop_form_register.dart';
import 'package:goop/pages/components/goop_images.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int selecionedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 100,
          //child: SvgPicture.asset(GoopImages.cadastro),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  GoopImages.avatar,
                  height: 150,
                ),
              ),
              GoopFormRegister(),
              RadioListTile(
                activeColor: GoopColors.green,
                value: 0,
                groupValue: 1,
                title: Text(
                  'Sou maior de 18 anos.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onChanged: (int ind) {
                  setState(() {
                    selecionedValue = ind;
                  });
                },
              ),
              RadioListTile(
                activeColor: GoopColors.green,
                value: 0,
                groupValue: selecionedValue,
                title: Text(
                  'Aceito os termos de uso.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onChanged: (int ind) {
                  setState(() {
                    selecionedValue = ind;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: GoopButton(
                  text: 'Finalizar',
                  action: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
