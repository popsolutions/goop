import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_mission_body.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:provider/provider.dart';
import '../components/goop_back.dart';
import 'package:goop/utils/goop_images.dart';

class MissionAboutPage extends StatefulWidget {
  @override
  _MissionAboutPageState createState() => _MissionAboutPageState();
}

class _MissionAboutPageState extends StateGoop<MissionAboutPage> {
  MissionModel currentMissionModel;
  Timer timer;

  bool _isRunning = true;

  void setTimeToCompletMission() {
    currentMissionModel.settimeToCompletMission();
    serviceNotifier.notifyListeners();
  }

  @override
  void didChangeDependencies() {
    if (didChangeDependenciesLoad == true) return;
    listenServiceNotifier = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!_isRunning) {
        timer.cancel();
        return;
      }
      setTimeToCompletMission();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _isRunning = false;
    super.dispose();
  }

  situacional({ifOrdered, ifInProgress, ifEndTime, ifDone, ifClosed}) {
    if (currentMissionModel.status == MissionStatus.Ordered) {
      return ifOrdered;
    } else if (currentMissionModel.status == MissionStatus.InProgress) {
      return ifInProgress;
    } else if (currentMissionModel.status == MissionStatus.EndTime) {
      return ifEndTime;
    } else if (currentMissionModel.status == MissionStatus.Done) {
      return ifDone;
    } else if (currentMissionModel.status == MissionStatus.Closed) {
      return ifClosed;
    } else
      throw 'Status de missão não implementado ';
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
                  ifOrdered: Column(
                    children: [
                      Text(
                        'Prazo para cumprir a missão:',
                        style: theme,
                      ),
                      paddingT(15),
                      Text(
                        // currentMissionModel.timeToCompletMission,
                        '3 Horas',
                        style: theme,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  ifInProgress: Column(
                    children: [
                      Text(
                        'Prazo para cumprir a missão:',
                        style: theme,
                      ),
                      paddingT(15),
                      Row(
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
                    ],
                  ),
                  ifEndTime: Text(
                    'Tempo Esgotado',
                    style: theme,
                    textAlign: TextAlign.center,
                  ),
                  ifDone: Text(
                    'Concluída',
                    style: theme,
                    textAlign: TextAlign.center,
                  ),
                  ifClosed: GestureDetector(
                    onTap: () {
                      navigatorPushNamed(
                        Routes.mission_completed,
                      );
                    },
                    child: Text(
                      'Concluída',
                      style: theme,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
              SizedBox(height: 10),
              situacional(
                ifOrdered: Container(),
                ifInProgress: Container(),
                ifEndTime: Container(),
                ifDone: Column(
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
                ifClosed: Container(),
              ),
              SizedBox(height: 20),
              Consumer<ServiceNotifier>(builder:
                  (BuildContext context, ServiceNotifier value, Widget child) {
                return situacional(
                  ifOrdered: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: (currentMissionModel.inProgress == false)
                          ? GoopButton(
                              text: 'Iniciar',
                              showCircularProgress: true,
                              action: () async {
                                await serviceNotifier
                                    .createOrUpdateGeoLocMeasurementModel();
                                serviceNotifier.notifyListeners();
                              },
                            )
                          : null),
                  ifInProgress: Container(),
                  ifEndTime: Container(),
                  ifDone: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: GoopButton(
                      text: 'Concluir Missão',
                      action: () async {
                        await dialogProcess(() async {
                          await serviceNotifier.measurementDone(context);
                        });

                        navigatorPushNamed(
                          Routes.mission_completed,
                        );
                      },
                    ),
                  ),
                  ifClosed: Container(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
