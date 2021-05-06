import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_colors.dart';
import 'package:goop/pages/components/goop_images.dart';

class GoopDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .4,
                child: DrawerHeader(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: GoopColors.red,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          minRadius: 40,
                          child: Icon(Icons.person),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Marília Costa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Missões Cumpridas: 0',
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 30,
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: GoopButton(
                            text: 'Missões',
                            action: () {},
                          ),
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          child: GoopButton(
                            text: 'Mapa',
                            action: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      goopTile(
                        title: 'Carteira',
                        img: GoopImages.wallet,
                        action: () {},
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
                        action: () {},
                      ),
                      SizedBox(height: 20),
                      goopTile(
                        title: 'Sair',
                        img: GoopImages.quit,
                        action: () => Navigator.popAndPushNamed(
                          context,
                          Routes.initial,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
