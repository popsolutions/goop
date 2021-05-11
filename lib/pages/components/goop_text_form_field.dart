import 'package:flutter/material.dart';

class GoopTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  const GoopTextFormField({
    Key key,
    this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        textAlign: TextAlign.center,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}
