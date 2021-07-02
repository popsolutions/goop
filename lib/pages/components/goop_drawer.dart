import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

class GoopDrawer extends StatefulWidget {
  @override
  _GoopDrawerState createState() => _GoopDrawerState();
}

class _GoopDrawerState extends StateGoop<GoopDrawer> {
  @override
  Widget build(BuildContext context) {
    // ServiceNotifier serviceNotifier =
    //     Provider.of<ServiceNotifier>(context, listen: false);
    AuthenticationController authenticationController =
        serviceNotifier.authenticationController;
    final user = authenticationController.currentUser;

    ListTile goopTile({String title, img, action}) {
      return ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: SvgPicture.asset(img, height: 20),
        title: Text(title),
        onTap: action,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(35),
        bottomRight: Radius.circular(35),
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 300,
              child: DrawerHeader(
                decoration: BoxDecoration(color: GoopColors.red),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: user.image == null
                            ? Image.asset(
                                GoopImages.empty_profile,
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              )
                            : Image.memory(
                                Base64Codec().decode(user.image),
                                fit: BoxFit.cover,
                                width: 150,
                                height: 150,
                              ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        user.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Missões Cumpridas: ${user.missionsCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: GoopButton(
                          text: 'Missões',
                          action: () {
                            serviceNotifier.viewByEstablishment = false;
                            navigatorPopAndPushNamed(
                              Routes.mission_home,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: GoopButton(
                          text: 'Mapa',
                          action: () {
                            navigatorPushReplacementNamed(
                              Routes.home,
                            );

                            // navigatorPushNamedAndRemoveUntil(
                            //   context,
                            //   Routes.home,
                            //   (route) => false,
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    goopTile(
                      title: 'Carteira',
                      img: GoopImages.wallet_red,
                      action: () {
                        navigatorPopAndPushNamed(
                          Routes.wallet,
                        );
                      },
                    ),
                    // goopTile(
                    //   title: 'Minha Conta',
                    //   img: GoopImages.account,
                    //   action: () {},
                    // ),
                    goopTile(
                      title: 'Minha Conta',
                      img: GoopImages.account,
                      action: () {
                        navigatorPopAndPushNamed(
                          Routes.settings,
                        );
                      },
                    ),
                    goopTile(
                      title: 'FAQ',
                      img: GoopImages.faq,
                      action: () {},
                    ),
                    goopTile(
                      title: 'Sair',
                      img: GoopImages.quit,
                      action: () => goop_LibComponents.navigatorPushNamedAndRemoveUntil(
                        context,
                        Routes.initial,
                        (route) => false,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
