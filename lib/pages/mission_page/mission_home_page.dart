import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/models/info.dart';
import 'package:goop/pages/components/goop_card.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class MissionHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GoopColors.red),
        centerTitle: true,
        title: Container(
          height: 40,
          child: SvgPicture.asset(
            GoopImages.mission,
          ),
        ),
      ),
      drawer: GoopDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                GoopImages.rocket,
                width: MediaQuery.of(context).size.width * .9,
              ),
              GoopCard(
                info: InfoMission(
                  title: 'Pão de Açúcar Morumbi',
                  address: 'Av. Prof. Francisco Morato, 2385',
                  content:
                      'Analisar o espaçode gôndola da marca Heineken e suas concorrentes em super mercados e mini mercados.',
                  price: 33,
                  time: '15 min',
                ),
              ),
              GoopCard(
                info: InfoMission(
                  title: 'Pão de Açúcar Morumbi',
                  address: 'Av. Prof. Francisco Morato, 2385',
                  content:
                      'Analisar o espaçode gôndola da marca Heineken e suas concorrentes em super mercados e mini mercados.',
                  price: 33,
                  time: '15 min',
                ),
              ),
              GoopCard(
                info: InfoMission(
                  title: 'Pão de Açúcar Morumbi',
                  address: 'Av. Prof. Francisco Morato, 2385',
                  content:
                      'Analisar o espaçode gôndola da marca Heineken e suas concorrentes em super mercados e mini mercados.',
                  price: 33,
                  time: '15 min',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
