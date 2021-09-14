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
      listMeasurementExecutedsDto = await serviceNotifier
          .measurementExecutedsService
          .getMeasurementExecutedsDto();
    } finally {
      loadFinish();
    }
  }

  statusColor(state) {
    switch (state) {
      case 'Concluída':
        return goopColors.green;
        break;
      case 'Aprovada':
        return goopColors.lightBlue;
        break;
      case 'Rejeitada':
        return goopColors.redSplash;
        break;
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
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    height: 60,
                    color: goopColors.redSplash,
                    child: Row(
                      children: [
                        Text(
                          'Missão',
                          style: TextStyle(
                            color: goopColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: paddingZ()),
                        Text(
                          'Valor',
                          style: TextStyle(
                            color: goopColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: paddingZ()),
                        Text(
                          'Status',
                          style: TextStyle(
                            color: goopColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                      child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: listMeasurementExecutedsDto.length,
                    separatorBuilder: (_, index) => SizedBox(height: 10),
                    itemBuilder: (_, index) {
                      final measurementExecutedsDto =
                          listMeasurementExecutedsDto[index];

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: goopColors.neutralGrey,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  measurementExecutedsDto.name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: goopColors.black,
                                  ),
                                ),
                                Expanded(child: paddingZ()),
                                Text(
                                  'R\$ ${formatCurrency(measurementExecutedsDto.reward)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: goopColors.black,
                                  ),
                                ),
                                Expanded(child: paddingZ()),
                                Text(
                                  measurementExecutedsDto.stateText,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: statusColor(
                                        measurementExecutedsDto.stateText),
                                  ),
                                ),
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
