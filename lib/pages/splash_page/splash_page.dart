import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
    ).then(
      (_) => Navigator.pushReplacementNamed(
        context,
        Routes.initial,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Container(color: GoopColors.red),
          Center(
            child: Container(
              height: 200,
              child: SvgPicture.asset(GoopImages.logo),
            ),
          ),
        ],
      ),
    );
  }
}
