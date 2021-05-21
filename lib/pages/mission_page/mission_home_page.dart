import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/pages/components/goop_card.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/services/mission_service.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:mobx/mobx.dart';

import 'mission_controller.dart';

class MissionHomePage extends StatefulWidget {
  @override
  _MissionHomePageState createState() => _MissionHomePageState();
}

class _MissionHomePageState extends State<MissionHomePage> {
  final _missionsController = MissionController(MissionService(Odoo()));

  @override
  void initState() {
    super.initState();
    _missionsController.load();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          SvgPicture.asset(
            GoopImages.rocket,
            width: MediaQuery.of(context).size.width * .9,
          ),
          Expanded(
            child: Observer(builder: (_) {
              final response = _missionsController.missionsRequest;

              switch (response.status) {
                case FutureStatus.rejected:
                  return Center(child: Text('Deu erro'));
                case FutureStatus.pending:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  final items = response.value;
                  if (items.isEmpty) {
                    return Center(child: Text('Está vazio'));
                  }
                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, index) => SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final item = items[index];

                      return GoopCard(
                        mission: item,
                      );
                    },
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}
