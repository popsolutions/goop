import 'dart:convert';
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

      await provider
          .insert_Measurement_photolines(base64Encode(file.readAsBytesSync()));

      Navigator.pop(context);
    }

    return Column(
      children: [
        SizedBox(height: 40),
        SvgPicture.asset(
          GoopImages.rocket,
          width: MediaQuery.of(context).size.width * .6,
        ),
        Column(
          children: [
            Text(
              widget.missionDto.name ?? '',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              widget.missionDto.address ?? '',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(color: Colors.black),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Text(
                widget.missionDto.subject ?? '',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(color: Colors.black),
            ),
            SizedBox(height: 20),
          ],
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
              Activity currentActivity =
                  widget.missionDto.missionModel.listActivity[index];

              return ListTile(
                leading: Icon(
                  (currentActivity.isChecked == true)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.deepPurple,
                ),
                title: Text(
                  widget.missionDto.missionModel.listActivity[index].name,
                  style: TextStyle(
                    color: currentActivity.isChecked
                        ? GoopColors.red
                        : GoopColors.darkBlue,
                  ),
                ),
                onTap: () async {
                  if (!provider.currentMissionModel.inProgress) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 2),
                        shape: StadiumBorder(),
                        backgroundColor: GoopColors.neutralGreen,
                        content: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'A Atividade não está iniciada 😉',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                    return;
                  }

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
                    if (provider.currentActivity.isChecked) {
                      Navigator.pushNamed(context, Routes.mission_photo_page,
                          arguments: widget.missionDto);
                    } else {
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
