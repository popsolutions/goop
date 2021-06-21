import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/mission_dto.dart';
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

enum MissionStatus {
  Ordered,
  InProgress,
  Completed,
}

class _MissionAboutPageState extends State<MissionAboutPage> {
  MissionModel currentMissionModel;
  var status = MissionStatus.Completed; //ALTERAR PARA MUDAR TELA
  bool _isRunning = true;

  String timeToCompletMission = '';

  void setTimeToCompletMission() {
    setState(() {
      try {
        if (currentMissionModel.inProgress == false)
          timeToCompletMission = '3 horas';
        else
          timeToCompletMission = currentMissionModel.getTimeToCompletMission();
      } catch (e) {
        timeToCompletMission = '';
      }
    });
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
    _isRunning = false;
  }

  situacional({ifCompleted, ifInProgress, ifOrdered}) {
    if (status == MissionStatus.Completed) {
      return ifCompleted;
    } else if (status == MissionStatus.InProgress) {
      return ifInProgress;
    } else {
      return ifOrdered;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle theme = Theme.of(context).textTheme.headline2;
    final MissionDto missionDto = ModalRoute.of(context).settings.arguments;
    currentMissionModel = missionDto.missionModel;
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          height: status == MissionStatus.Completed ? 40 : 60,
          child: SvgPicture.asset(
            status == MissionStatus.Completed
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
              GoopMissionBody(missionDto: missionDto),
              situacional(
                ifCompleted: Text(
                  timeToCompletMission,
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
                      timeToCompletMission,
                      style: theme,
                    ),
                  ],
                ),
                ifOrdered: Text(
                  'Tempo Esgotado',
                  style: theme,
                ),
              ),
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
                      'R\$ ${missionDto.reward.toStringAsFixed(2) ?? ''}',
                      style: theme,
                    ),
                  ],
                ),
                ifInProgress: Container(),
                ifOrdered: Container(),
              ),
              SizedBox(height: 20),
              situacional(
                ifCompleted: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: (currentMissionModel.inProgress == false)
                        ? GoopButton(
                            text: 'Iniciar',
                            action: () async {
                              await serviceNotifier
                                  .createMeasurementModelIfNotExists();
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
                      Navigator.pushNamed(
                        context,
                        Routes.mission_completed,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
