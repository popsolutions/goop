import 'package:flutter/material.dart';
import 'package:goop/pages/components/goop_colors.dart';

class GoopButton extends StatelessWidget {
  final String text;
  final action;

  const GoopButton({
    Key key,
    @required this.text,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * .45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          primary: GoopColors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: GoopColors.neutralGrey,
            fontSize: 18,
          ),
        ),
        onPressed: action,
      ),
    );
  }
}
