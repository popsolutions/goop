import 'package:flutter/material.dart';
import 'package:goop/pages/components/goop_close.dart';

class GoopAlert extends StatelessWidget {
  final String title;
  final contet;

  GoopAlert({
    this.title,
    @required this.contet,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      backgroundColor: Color(0XFFF0F5F7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title != null
              ? Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                )
              : Container(),
          GoopClose(),
        ],
      ),
      content: contet,
    );
  }
}
