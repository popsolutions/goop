import 'package:flutter/material.dart';

class GoopTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(String value) onChanged;

  const GoopTextFormField({
    Key key,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        onChanged: onChanged,
        textAlign: TextAlign.center,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}
