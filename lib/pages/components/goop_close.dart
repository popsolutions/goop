import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class GoopClose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Stack(
        alignment: Alignment(0, 0),
        children: [
          SvgPicture.asset(
            GoopImages.close,
            width: 50,
          ),
          Text(
            'X',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: GoopColors.red,
            ),
          )
        ],
      ),
    );
  }
}
