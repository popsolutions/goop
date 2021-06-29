import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/pages/settings_page/preview_page.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MissionPriceComparisionPage extends StatefulWidget {
  @override
  _MissionPriceComparisionPageState createState() =>
      _MissionPriceComparisionPageState();
}

class _MissionPriceComparisionPageState
    extends StateGoop<MissionPriceComparisionPage> {
  ServiceNotifier serviceNotifier;
  @override
  String archive;
  final _priceController = TextEditingController();
  double price() => CurrencyStringtoDouble(_priceController.text);

  Future<void> save(BuildContext context) async {
    await serviceNotifier.insert_Measurement_PriceComparisonLinesModel(
        price(), archive);
    Navigator.pop(context);
  }

  bool editing() => !serviceNotifier.currentActivity.isChecked;

  Widget build(BuildContext context) {

    final TextStyle theme = Theme.of(context).textTheme.headline2;
    //final MissionDto missionDto = ModalRoute.of(context).settings.arguments;
    serviceNotifier = Provider.of<ServiceNotifier>(context, listen: false);
    Activity currentActivity = serviceNotifier.currentActivity;

    if ((currentActivity.measurementPriceComparisonLinesModel != null) &&
        (archive == null)) {
      setState(() {
        archive = currentActivity.measurementPriceComparisonLinesModel.photo;
        _priceController.text = currentActivity.measurementPriceComparisonLinesModel.price.toString();

      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          height: 60,
          child: SvgPicture.asset(GoopImages.price_comparison),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'PRODUTOS',
                      style: theme,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Divider(color: Colors.deepPurple),
                    ),
                    Text(
                      currentActivity.name,
                      style: theme,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Preço',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 30),

                    goop_LibComponents.getInputTextFormField('',
                        _priceController, keyboardType: TextInputType.number,
                        readOnly: currentActivity.isChecked,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, CurrencyInputFormatter()],
                        autoFocus: false,
                        textAlign: TextAlign.center,
                        border: false,
                    ),
                    paddingT(20),
                    circularImageBase64(archive, onTap: () async {
                          if (!editing()) return null;

                          String fileBase64 =  await getPhotoBase64();

                          if (fileBase64 != null)
                            archive = fileBase64;

                          setState(() {});
                    })

                  ],
                ),
                (serviceNotifier.currentActivity.isChecked)
                    ? paddingZ()
                    : Container(
                        child: GoopButton(
                          text: 'Salvar',
                          showCircularProgress: true,
                          action: () async {
                            await save(context);
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
