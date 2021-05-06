import 'package:flutter/material.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';

class GoopFormRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        children: [
          GoopTextFormField(hintText: 'Nome Completo'),
          GoopTextFormField(hintText: 'CPF'),
          Row(
            children: [
              Flexible(child: GoopTextFormField(hintText: 'Nascimento')),
              SizedBox(width: 30),
              Flexible(child: GoopTextFormField(hintText: 'Gênero')),
            ],
          ),
          GoopTextFormField(hintText: 'E-mail'),
          GoopTextFormField(hintText: 'Celular'),
          GoopTextFormField(hintText: 'CEP'),
          GoopTextFormField(hintText: 'PIX'),
        ],
      ),
    );
  }
}
