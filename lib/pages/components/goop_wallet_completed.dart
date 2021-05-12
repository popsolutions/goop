import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/utils/goop_images.dart';

class GoopWalletCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          GoopImages.draw_money,
          height: 60,
        ),
        SizedBox(height: 20),
        SvgPicture.asset(
          GoopImages.red_smile,
          height: 30,
        ),
      ],
    );
  }
}
