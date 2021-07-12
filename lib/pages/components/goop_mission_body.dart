import 'dart:convert';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/settings_page/preview_page.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

class GoopMissionBody extends StatefulWidget {
  final MissionModel currentMissionModel_;
  GoopMissionBody({@required this.currentMissionModel_});

  @override
  _GoopMissionBodyState createState() => _GoopMissionBodyState();
}

class _GoopMissionBodyState extends StateGoop<GoopMissionBody> {
  @override
  Widget build(BuildContext context) {
    final TextStyle theme = Theme.of(context).textTheme.headline2;

    MissionModel currentMissionModel = widget.currentMissionModel_;
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
              currentMissionModel.name ?? '',
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              currentMissionModel.address ?? '',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(color: goopColors.black),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Text(
                currentMissionModel.subject ?? '',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Divider(color: goopColors.black),
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
          child: Divider(color: goopColors.deepPurple),
        ),
        Consumer<ServiceNotifier>(builder:
            (BuildContext context, ServiceNotifier value, Widget child) {
          return Container(
            width: MediaQuery.of(context).size.width * .7,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: currentMissionModel.listActivity.length,
              itemBuilder: (_, index) {
                Activity currentActivity =
                    currentMissionModel.listActivity[index];

                return ListTile(
                  enabled: currentMissionModel.inProgressOrDone,
                  focusColor: goopColors.grey400,
                  leading: Icon(
                    (currentActivity.isChecked == true)
                        ? Icons.star
                        : Icons.star_border,
                    color: currentMissionModel.inProgressOrDone
                        ? goopColors.deepPurple
                        : goopColors.grey400,
                  ),
                  title: Text(
                    currentMissionModel.listActivity[index].name,
                    style: TextStyle(
                      color: (currentMissionModel.inProgressOrDone)
                          ? currentActivity.isChecked
                              ? goopColors.red
                              : goopColors.darkBlue
                          : goopColors.grey400,
                    ),
                  ),
                  onTap: () async {
                    await dialogProcess(() async {
                      await serviceNotifier.setcurrentActivity(
                          currentMissionModel.listActivity[index]);
                    });

                    if (serviceNotifier.currentActivity.isQuizz()) {
                      navigatorPushNamed(
                        Routes.mission_question,
                        arguments: currentMissionModel,
                      );
                    } else if (serviceNotifier.currentActivity
                        .isPriceComparison()) {
                      navigatorPushNamed(
                        Routes.mission_price_comparison,
                        arguments: currentMissionModel,
                      );
                    } else if (serviceNotifier.currentActivity.isPhoto()) {
                      if (serviceNotifier.currentActivity.isChecked) {
                        navigatorPushNamed(
                          Routes.mission_photo_page,
                          arguments: currentMissionModel,
                        );
                      } else {
                        String file = await getPhotoBase64();

                        if (file != null)
                          dialogProcess(() async {
                            await serviceNotifier.insert_Measurement_photolines(file, context);
                          });
                      }
                    }
                  },
                );
              },
            ),
          );
        }),
        Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Divider(color: goopColors.deepPurple),
        ),
      ],
    );
  }
}
