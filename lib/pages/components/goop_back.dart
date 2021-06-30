import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/pages/components/goop_libComponents.dart';

class GoopBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(15),
        child: SvgPicture.asset(
          GoopImages.back,
        ),
      ),
      onTap: () => goop_LibComponents.navigatorPop(context),
    );
  }
}
