import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/mission_dto.dart';
import 'package:goop/pages/components/goop_card.dart';
import 'package:goop/pages/settings_page/preview_page.dart';
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
    final TextStyle theme = Theme.of(context).textTheme.headline2;
    final provider = Provider.of<ServiceNotifier>(context);

    Future<void> showPreview(File file) async {
      file = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PreviewPage(file),
        ),
      );
      Navigator.pop(context);
    }

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
                title: Text(
                  widget.missionDto.missionModel.listActivity[index].name,
                  style: TextStyle(color: GoopColors.darkBlue),
                ),
                onTap: () async {
                  await provider.setcurrentActivity(
                      widget.missionDto.missionModel.listActivity[index]);

                  if (provider.currentActivity.isQuizz()) {
                    Navigator.pushNamed(
                      context,
                      Routes.mission_question,
                      arguments: widget.missionDto,
                    );
                  } else if (provider.currentActivity.isPriceComparison()) {
                    Navigator.pushNamed(
                      context,
                      Routes.mission_price_comparison,
                      arguments: widget.missionDto,
                    );
                  } else if (provider.currentActivity.isPhoto()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CameraCamera(
                          enableZoom: true,
                          onFile: (file) async => await showPreview(file),
                        ),
                      ),
                    );
                  }
                },
              );
            },
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
