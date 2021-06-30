import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_mission_body.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/global.dart';
import 'package:provider/provider.dart';
import '../components/goop_back.dart';
import 'package:goop/utils/goop_images.dart';

class MissionAboutPage extends StatefulWidget {
  @override
  _MissionAboutPageState createState() => _MissionAboutPageState();
}

class _MissionAboutPageState extends StateGoop<MissionAboutPage> {
  MissionModel currentMissionModel;

  bool _isRunning = true;

  void setTimeToCompletMission() {
    currentMissionModel.settimeToCompletMission();
    serviceNotifier.notifyListeners();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!_isRunning) {
        timer.cancel();
        return;
      }
      setTimeToCompletMission();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _isRunning = false;
  }

  situacional({ifCompleted, ifInProgress, ifOrdered}) {
    if (currentMissionModel.status == MissionStatus.Ordered) {
      return ifCompleted;
    } else if (currentMissionModel.status == MissionStatus.InProgress) {
      return ifInProgress;
    } else {
      return ifOrdered;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle theme = Theme.of(context).textTheme.headline2;
    currentMissionModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GoopBack(),
        title: Container(
          height: currentMissionModel.status == MissionStatus.Closed ? 40 : 60,
          child: Image.asset(
            currentMissionModel.status == MissionStatus.Ordered
                ? GoopImages.mission_about
                : GoopImages.mission_in_progress,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              GoopMissionBody(currentMissionModel_: currentMissionModel),
              Consumer<ServiceNotifier>(builder:
                  (BuildContext context, ServiceNotifier value, Widget child) {
                return situacional(
                  ifCompleted: Text(
                    currentMissionModel.timeToCompletMission,
                    style: theme,
                    textAlign: TextAlign.center,
                  ),
                  ifInProgress: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        GoopImages.clock,
                        height: 60,
                      ),
                      SizedBox(width: 20),
                      Text(
                        currentMissionModel.timeToCompletMission,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  ifOrdered: Text(
                    'Tempo Esgotado',
                    style: theme,
                  ),
                );
              }),
              SizedBox(height: 10),
              situacional(
                ifCompleted: Column(
                  children: [
                    Text(
                      'Prêmio da missão: ',
                      style: theme,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Divider(color: Colors.deepPurple),
                    ),
                    Text(
                      'R\$ ${currentMissionModel.reward.toStringAsFixed(2) ?? ''}',
                      style: theme,
                    ),
                  ],
                ),
                ifInProgress: Container(),
                ifOrdered: Container(),
              ),
              SizedBox(height: 20),
              Consumer<ServiceNotifier>(builder:
                  (BuildContext context, ServiceNotifier value, Widget child) {
                return situacional(
                  ifCompleted: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: (currentMissionModel.inProgress == false)
                          ? GoopButton(
                              text: 'Iniciar',
                              showCircularProgress: true,
                              action: () async {
                                await serviceNotifier.createOrUpdateGeoLocMeasurementModel();
                                serviceNotifier.notifyListeners();
                              },
                            )
                          : null),
                  ifInProgress: Container(),
                  ifOrdered: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: GoopButton(
                      text: 'Enviar',
                      action: () {
                        navigatorPushNamed(
                          Routes.mission_completed,
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
