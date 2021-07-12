import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class InitialPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    globalConfig.darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
              action: () => goop_LibComponents.navigatorPushNamed(
                context,
                Routes.login,
              ),
            ),
            GoopButton(
                text: 'Cadastre-se Agora',
                buttonColor: goopColors.white,
                textColor: goopColors.red,
                borderColor: goopColors.red,
                action: () {
                  Navigator.pushNamed(
                    context,
                    Routes.register,
                  );
                }
                // action: () => launch('https://dev.charismabi.com/web/signup'),
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
