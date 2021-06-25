import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/models/mission_dto.dart';
import 'package:goop/pages/components/StateGoop.dart';
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

class _MissionHomePageState extends StateGoop<MissionHomePage> {
  List<MissionModel> listMissionModel;

  @override
  void initState() {
    super.initState();
    listenServiceNotifier = true;
  }

  @override
  Widget build(BuildContext context) {

    if (serviceNotifier.viewByEstablishment == true)
      listMissionModel = serviceNotifier.currentMissionModelEstablishment.listMissionModel;
    else
      listMissionModel = serviceNotifier.listMissionModel;

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
          await serviceNotifier.update();
          serviceNotifier.notifyListeners();
        },
        child: Column(
          children: [
            Expanded(
              child:  ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: listMissionModel.length,
                    separatorBuilder: (_, index) => SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final currentMissionModel = listMissionModel[index];

                      return Column(
                        children: [
                          if (index == 0)
                            SvgPicture.asset(
                              GoopImages.rocket,
                              width: MediaQuery.of(context).size.width * .9,
                            ),
                          GoopCard(
                           currentMissionModel: currentMissionModel
                          ),
                        ],
                      );
                    },
                  )
              ),
          ],
        ),
      ),
    );
  }
}
