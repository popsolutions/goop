import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

class GoopDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceNotifier serviceNotifier =
        Provider.of<ServiceNotifier>(context, listen: false);
    AuthenticationController authenticationController =
        serviceNotifier.authenticationController;
    final user = authenticationController.currentUser;

    ListTile goopTile({String title, img, action}) {
      return ListTile(
        dense: true,
        contentPadding: EdgeInsets.all(20),
        leading: SvgPicture.asset(img, height: 25),
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
              height: MediaQuery.of(context).size.height * .4,
              child: DrawerHeader(
                padding: EdgeInsets.all(0),
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
                      SizedBox(height: 10),
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
                            Navigator.pushNamed(
                              context,
                              Routes.mission_home,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        child: GoopButton(
                          text: 'Mapa',
                          action: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              Routes.home,
                              (route) => false,
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
                        Navigator.pushNamed(
                          context,
                          Routes.wallet,
                        );
                      },
                    ),
                    goopTile(
                      title: 'Minha Conta',
                      img: GoopImages.account,
                      action: () {},
                    ),
                    goopTile(
                      title: 'FAQ',
                      img: GoopImages.faq,
                      action: () {},
                    ),
                    goopTile(
                      title: 'Configurações',
                      img: GoopImages.settings,
                      action: () {
                        Navigator.pushNamed(
                          context,
                          Routes.settings,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    goopTile(
                      title: 'Sair',
                      img: GoopImages.quit,
                      action: () => Navigator.pushNamedAndRemoveUntil(
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
