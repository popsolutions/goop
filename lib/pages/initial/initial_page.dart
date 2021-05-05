import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_images.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment(0, 0),
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .5,
                child: SvgPicture.asset(GoopImages.initial),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .25,
                child: Center(
                  child: SvgPicture.asset(GoopImages.logo),
                ),
              ),
            ],
          ),
          GoopButton(
            text: 'Login',
            action: () => Navigator.pushNamed(
              context,
              Routes.login,
            ),
          ),
        ],
      ),
    );
  }
}
