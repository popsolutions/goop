import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/models/mission_dto.dart';
import 'package:goop/pages/components/goop_card.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/services/establishment/establishment_controller.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'mission_controller.dart';

class MissionHomePage extends StatefulWidget {
  @override
  _MissionHomePageState createState() => _MissionHomePageState();
}

class _MissionHomePageState extends State<MissionHomePage> {
  MissionController _missionsController;
  EstablishmentController _establishmentsController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);

    if (_missionsController == null) {
      _missionsController = serviceNotifier.missionsController;
      _establishmentsController = serviceNotifier.establishmentsController;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GoopColors.red),
        centerTitle: true,
        title: Container(
          height: 40,
          child: SvgPicture.asset(GoopImages.mission),
        ),
      ),
      drawer: GoopDrawer(),
      body: RefreshIndicator(
        strokeWidth: 3,
        color: GoopColors.red,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          await serviceNotifier.update();
        },
        child: Column(
          children: [
            Expanded(
              child: Observer(
                builder: (_) {
                  final responseMissions = _missionsController.missionsRequest;
                  final responseEstablishments =
                      _establishmentsController.establishmentsRequest;

                  if (responseMissions.status == FutureStatus.rejected ||
                      responseEstablishments.status == FutureStatus.rejected) {
                    return Center(child: Text('Deu erro'));
                  } else if (responseMissions.status == FutureStatus.pending ||
                      responseEstablishments.status == FutureStatus.pending) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final missions = responseMissions.value;
                  final establishments = responseEstablishments.value;

                  if (missions.isEmpty) {
                    return Center(child: Text('Está vazio'));
                  }

                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: missions.length,
                    separatorBuilder: (_, index) => SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final mission = missions[index];
                      final establishment = establishments[index];

                      return Column(
                        children: [
                          if (index == 0)
                            SvgPicture.asset(
                              GoopImages.rocket,
                              width: MediaQuery.of(context).size.width * .9,
                            ),
                          GoopCard(
                            missionDto: MissionDto(
                              name: mission.name,
                              subject: mission.subject,
                              partnerId: mission.partnerId,
                              establishmentId: mission.establishmentId,
                              measurementCount: mission.measurementCount,
                              createByUserId: mission.createByUserId,
                              limit: mission.limit,
                              priority: mission.priority,
                              scores: mission.scores,
                              reward: mission.reward,
                              typeMission: mission.typeMission,
                              instructions: mission.instructions,
                              missionState: mission.missionState,
                              address: mission.address,
                              dateCreated: mission.dateCreated,
                              dateFinished: mission.dateFinished,
                              price: mission.price,
                              time: mission.time,
                              nameEstablishment: establishment.name,
                              addressEstablishment: establishment.address,
                              latitude: establishment.latitude,
                              longitude: establishment.longitude,
                              id: establishment.id,
                              missionModel: mission,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
