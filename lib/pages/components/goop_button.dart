import 'package:flutter/material.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:provider/provider.dart';

class GoopButton extends StatefulWidget {
  final String text;
  final Function action;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final bool isLoading;
  final bool showCircularProgress;

  const GoopButton(
      {Key key,
      @required this.text,
      this.action,
      this.buttonColor = GoopColors.red,
      this.textColor = GoopColors.neutralGrey,
      this.borderColor = Colors.transparent,
      this.isLoading = false,
      this.showCircularProgress = false})
      : super(key: key);

  @override
  _GoopButtonState createState() => _GoopButtonState();
}

class _GoopButtonState extends StateGoop<GoopButton> {
  @override
  Widget build(BuildContext context) {
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        margin: EdgeInsets.only(top: 15),
        width: MediaQuery.of(context).size.width * .6,
        child: Consumer<ServiceNotifier>(builder:
            (BuildContext context, ServiceNotifier value, Widget child) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
              primary: widget.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: widget.borderColor),
              ),
            ),
            child: widget.isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            onPressed: () async {
              if (widget.showCircularProgress == true) {
                await dialogProcess(() async {
                  await widget.action();
                });
              } else {
                widget.action();
              }
            },
          );
        }),
      ),
    );
  }
}
