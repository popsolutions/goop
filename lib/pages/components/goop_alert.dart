import 'package:flutter/material.dart';
import 'package:goop/utils/goop_colors.dart';

class GoopAlert extends StatelessWidget {
  final title;
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
          title != null ? title : Container(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Stack(
              alignment: Alignment(0, 0),
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    color: GoopColors.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      content: contet,
    );
  }
}
