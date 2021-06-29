import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoopTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Function(String value) onChanged;
  final Function(String) validator;
  final AutovalidateMode autovalidateMode;
  final String initialValue;
  final List<TextInputFormatter> inputFormatters;
  final bool enable;
  final keyboardType;

  const GoopTextFormField({
    Key key,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.inputFormatters,
    this.enable = true,
    this.keyboardType = TextInputType.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        initialValue: initialValue,
        autovalidateMode: autovalidateMode,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        enabled: enable,
      ),
    );
  }
}
