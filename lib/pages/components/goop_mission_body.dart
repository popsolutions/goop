import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/mission_dto.dart';
import 'package:goop/pages/components/goop_card.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

class GoopMissionBody extends StatefulWidget {
  final MissionDto missionDto;
  GoopMissionBody({@required this.missionDto});

  @override
  _GoopMissionBodyState createState() => _GoopMissionBodyState();
}

class _GoopMissionBodyState extends State<GoopMissionBody> {
  @override
  Widget build(BuildContext context) {
    //print(widget.missionDto.listActivity.length);

    final TextStyle theme = Theme.of(context).textTheme.headline2;
    final provider = Provider.of<ServiceNotifier>(context);

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
          child: Divider(color: Colors.deepPurple),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.missionDto.missionModel.listActivity.length,
            itemBuilder: (_, index) {

              Activity currentActivity = widget.missionDto.missionModel.listActivity[index];

              return ListTile(
                leading: Icon(
                  (currentActivity.isChecked == true) ? Icons.star : Icons.star_border,
                  color: Colors.deepPurple,
                ),
                title: TextButton(
                  child: Text(
                    widget.missionDto.missionModel.listActivity[index].name,
                    style: TextStyle(
                      color: GoopColors.red,
                      //isSelected1 ? GoopColors.red : Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () async {
                    await provider.setcurrentActivity(widget.missionDto.missionModel.listActivity[index]);

                    String route = '';

                    if (provider.currentActivity.isPriceComparison())
                      route = Routes
                          .mission_question; //??-pedro- Pedro, pelo que eu entendi o conteúdo dos arquivos "MissionPriceComparisionPage.dart" e "MissionQuestionPage.dart" estão invertidos
                    else if (provider.currentActivity.isQuizz())
                      route = Routes.mission_price_comparison;
                    else if (provider.currentActivity.isPhoto())
                      route =
                          ''; //??-pedro-Definiar a variável route para Fotografia//TODO: TRATAR QUAL TELA SERÁ CHAMADA

                    Navigator.pushNamed(
                      context,
                      route,
                      arguments: widget.missionDto,
                    );
                  },
                ),
              );
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: ListTile(
            onTap: () {},
            leading: Icon(
              // isSelected2 ? Icons.star : Icons.star_border,
              Icons.star,
              color: Colors.deepPurple,
            ),
            title: TextButton(
              child: Text(
                'Comparativo de preços',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: GoopColors.red,
                  //isSelected2 ? GoopColors.red : Colors.black,
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
          child: Divider(color: Colors.deepPurple),
        ),
      ],
    );
  }
}
