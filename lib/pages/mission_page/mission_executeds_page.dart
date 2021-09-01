import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/config/app/authentication_controller.dart';
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/dtos/MeasurementExecutedsDto.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_alert.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_card.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/pages/settings_page/settings_controller.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/services/login/user_service.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/utils.dart';
import 'package:goop/utils/validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class Mission_executeds_Page extends StatefulWidget {
  @override
  _Mission_executedsPageS_tate createState() => _Mission_executedsPageS_tate();
}

class _Mission_executedsPageS_tate extends StateGoop<Mission_executeds_Page> {
  List<MeasurementExecutedsDto> listMeasurementExecutedsDto;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    listMissionModelSet();
  }

  listMissionModelSet() async {
    try {
      listMeasurementExecutedsDto = await serviceNotifier.measurementExecutedsService.getMeasurementExecutedsDto();
    } finally {
      loadFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        centerTitle: true,
        title: Container(
          width: 100,
          child: Image.asset(GoopImages.mission),
        ),
      ),
      drawer: GoopDrawer(),
      body: loading
          ? inProgress()
          : RefreshIndicator(
              strokeWidth: 3,
              color: goopColors.red,
              onRefresh: () async {
                await serviceNotifier.update();
                listMissionModelSet();
                serviceNotifier.notifyListeners();
              },
              child: Column(
                children: [
                  paddingT(30),
                  Container(
                    color: Colors.black12,
                    child: Row(
                      children: [
                        Text('Missão'),
                        Expanded(child: paddingZ()),
                        Text('Valor'),
                        Expanded(child: paddingZ()),
                        Text('Status'),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: listMeasurementExecutedsDto.length,
                    separatorBuilder: (_, index) => SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final measurementExecutedsDto = listMeasurementExecutedsDto[index];

                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(measurementExecutedsDto.name ?? ''),
                                Expanded(child: paddingZ()),
                                Text(formatCurrency(measurementExecutedsDto.reward)),
                                Expanded(child: paddingZ()),
                                Text(measurementExecutedsDto.stateText),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )),
                ],
              ),
            ),
    );
  }
}
