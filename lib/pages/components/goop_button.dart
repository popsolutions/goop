import 'package:flutter/material.dart';
import 'package:goop/pages/components/goop_colors.dart';

class GoopButton extends StatelessWidget {
  final String text;
  final Function action;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;

  const GoopButton({
    Key key,
    @required this.text,
    this.action,
    this.buttonColor = GoopColors.red,
    this.textColor = GoopColors.neutralGrey,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width * .6,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
        ),
        onPressed: action,
      ),
    );
  }
}
