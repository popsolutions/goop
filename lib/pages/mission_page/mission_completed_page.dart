import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/utils/goop_images.dart';

class MissionCompletedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          height: 80,
          child: SvgPicture.asset(
            GoopImages.mission_completed,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                child: SvgPicture.asset(
                  GoopImages.rocket_completed,
                ),
              ),
              Container(
                height: 100,
                child: SvgPicture.asset(
                  GoopImages.msg_completed,
                ),
              ),
              SizedBox(height: 30),
              GoopButton(
                text: 'Home',
                action: () {
                  Navigator.pushNamed(
                    context,
                    Routes.white_splash,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
