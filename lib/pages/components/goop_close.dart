import 'package:flutter/material.dart';
import 'package:goop/utils/goop_colors.dart';

class GoopClose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
