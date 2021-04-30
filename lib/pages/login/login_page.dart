import 'package:flutter/material.dart';
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
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GoopTextFormField(
                hintText: "E-mail",
              ),
              GoopTextFormField(
                hintText: "Senha",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
