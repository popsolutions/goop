import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:goop/models/user_profile.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class GoopFormRegister extends StatelessWidget {
  UserProfile userProfile;
  GoopFormRegister(this.userProfile);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          GoopTextFormField(hintText: 'Login', onChanged: (value) => userProfile.login = value),
          GoopTextFormField(hintText: 'Nome Completo', onChanged: (value) => userProfile.name = value),
          GoopTextFormField(hintText: 'CPF', onChanged: (value) => userProfile.cnpjCpf = value, keyboardType: TextInputType.number, inputFormatters: [MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')})]),
          Row(
            children: [
              Flexible(child: GoopTextFormField(hintText: 'Nascimento', onChanged: (value) => userProfile.birthdate = value)),
              SizedBox(width: 30),
              Flexible(child: GoopTextFormField(hintText: 'Gênero', onChanged: (value) => userProfile.gender = value)),
            ],
          ),
          GoopTextFormField(hintText: 'E-mail', onChanged: (value) => userProfile.email = value),
          GoopTextFormField(hintText: 'Celular', onChanged: (value) => userProfile.phone = value),
          GoopTextFormField(hintText: 'CEP', onChanged: (value) => userProfile.zip = value),
          GoopTextFormField(hintText: 'Senha', onChanged: (value) => userProfile.password = value, obscureText: true),
        ],
      ),
    );
  }
}
