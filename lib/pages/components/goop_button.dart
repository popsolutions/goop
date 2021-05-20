import 'package:flutter/material.dart';
import 'package:goop/utils/goop_colors.dart';

class GoopButton extends StatelessWidget {
  final String text;
  final Function action;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final bool isLoading;

  const GoopButton({
    Key key,
    @required this.text,
    this.action,
    this.buttonColor = GoopColors.red,
    this.textColor = GoopColors.neutralGrey,
    this.borderColor = Colors.transparent,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
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
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
        onPressed: action,
      ),
    );
  }
}
