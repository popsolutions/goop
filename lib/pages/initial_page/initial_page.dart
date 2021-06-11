import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 60),
            GoopButton(
              text: 'Login',
              action: () => Navigator.pushNamed(
                context,
                Routes.login,
              ),
            ),
            GoopButton(
              text: 'Cadastre-se Agora',
              buttonColor: Colors.white,
              textColor: GoopColors.red,
              borderColor: GoopColors.red,
              action: () => Navigator.pushNamed(context, Routes.register),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          height: 35,
          child: SvgPicture.asset(GoopImages.charisma),
        ),
      ),
    );
  }
}
