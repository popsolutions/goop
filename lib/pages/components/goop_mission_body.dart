import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission_dto.dart';
import 'package:goop/pages/components/goop_card.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class GoopMissionBody extends StatefulWidget {
  final MissionDto missionDto;
  GoopMissionBody({@required this.missionDto});

  @override
  _GoopMissionBodyState createState() => _GoopMissionBodyState();
}

class _GoopMissionBodyState extends State<GoopMissionBody> {
  bool isSelected1 = false;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    print(widget.missionDto.listActivity.length);

    final TextStyle theme = Theme.of(context).textTheme.headline2;

    return Column(
      children: [
        SizedBox(height: 40),
        SvgPicture.asset(
          GoopImages.rocket,
          width: MediaQuery.of(context).size.width * .6,
        ),
        GoopCard(
          goToPage: false,
          missionDto: widget.missionDto,
          border: Colors.transparent,
          showPrinceAndTime: false,
        ),
        Text(
          'Como executar a missão:',
          style: theme,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Divider(
            color: Colors.deepPurple,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: ListTile(
            onTap: () {
              setState(() {
                isSelected1 = !isSelected1;
              });
            },
            leading: Icon(
              isSelected1 ? Icons.star : Icons.star_border,
              color: Colors.deepPurple,
            ),
            title: TextButton(
              child: Text(
                'Tirar foto da gôndola de cervejas',
                style: TextStyle(
                  color: isSelected1 ? GoopColors.red : Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.mission_question,
                );
              },
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: ListTile(
            onTap: () {
              setState(() {
                isSelected2 = !isSelected2;
              });
            },
            leading: Icon(
              isSelected2 ? Icons.star : Icons.star_border,
              color: Colors.deepPurple,
            ),
            title: TextButton(
              child: Text(
                'Comparativo de preços',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: isSelected2 ? GoopColors.red : Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.mission_price_comparison,
                );
              },
            ),
          ),
        ),
        Text(
          'Prazo para cumprir a missão:',
          style: theme,
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Divider(
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
