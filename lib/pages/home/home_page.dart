import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_colors.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/pages/components/goop_images.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GoopColors.red),
        actions: [
          Container(
            width: 45,
            margin: EdgeInsets.only(right: 20),
            child: SvgPicture.asset(GoopImages.red_smile),
          ),
        ],
      ),
      drawer: GoopDrawer(),
      body: Container(),
    );
  }
}
