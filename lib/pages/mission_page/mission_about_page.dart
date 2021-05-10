import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/info.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_card.dart';
import 'package:goop/utils/goop_images.dart';

class MissionAboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InfoMission info = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          height: 40,
          child: SvgPicture.asset(
            GoopImages.mission_about,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              GoopImages.rocket,
              width: MediaQuery.of(context).size.width * .6,
            ),
            GoopCard(
              info: info,
              border: Colors.transparent,
              showPrinceAndTime: false,
            ),
            Text('Como executar a missão:'),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(
                color: Colors.deepPurple,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              child: ListTile(
                leading: Icon(Icons.star_border),
                title: TextButton(
                  child: Text('Tirar foto da gôndola de cervejas'),
                  onPressed: () {},
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              child: ListTile(
                leading: Icon(Icons.star_border),
                title: TextButton(
                  child: Text('Comparativo de preços'),
                  onPressed: () {},
                ),
              ),
            ),
            GoopButton(
              text: 'Inciar',
              action: () {},
            ),
          ],
        ),
      ),
    );
  }
}
