import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/global.dart';
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

    ListTile goopTile({String title, img, action, useSvg = true}) {
      return ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: useSvg ? SvgPicture.asset(img, height: 20) : img,
        title: Text(title, style: TextStyle(color: goopColors.black)),
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
              decoration: BoxDecoration(color: goopColors.white),
              child: DrawerHeader(
                decoration: BoxDecoration(color: goopColors.red),
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
                          color: goopColors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Missões Cumpridas: ${user.missionsCount}',
                        style: TextStyle(
                          color: goopColors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: goopColors.white),
              child: Column(
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
                              navigatorPop(null, false);
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
                        useSvg: false,
                        title: 'Chat',
                        img: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.red,
                        ),
                        action: () {
                          navigatorPopAndPushNamed(
                            Routes.chat,
                          );
                        },
                      ),
                      goopTile(
                        title: 'FAQ',
                        img: GoopImages.faq,
                        action: () {},
                      ),
                      goopTile(
                        useSvg: false,
                        title: (globalConfig.darkMode)
                            ? 'Modo Claro'
                            : 'Modo Escuro',
                        img: Icon(
                          (globalConfig.darkMode)
                              ? Icons.dark_mode_outlined
                              : Icons.light_mode_outlined,
                          color: Colors.red,
                        ),
                        action: () {
                          globalConfig.darkMode = !globalConfig.darkMode;
                          globalRebuildAllChildren();
                        },
                      ),
                      goopTile(
                        title: 'Sair',
                        img: GoopImages.quit,
                        action: () async {
                          await serviceNotifier.close();
                          goop_LibComponents.navigatorPushNamedAndRemoveUntil(
                            context,
                            Routes.initial,
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
