import 'package:flutter/material.dart';

class GoopTextFormField extends StatelessWidget {
  static const _kMinHeight = 109.0;
  final String hintText;

  const GoopTextFormField({Key key, this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _kMinHeight),
      child: TextFormField(
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
