import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/utils.dart';
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
  ImageGoop archive = ImageGoop();
  final _priceController = TextEditingController();
  double price() => CurrencyStringtoDouble(_priceController.text);
  bool editing() => !serviceNotifier.currentActivity.isChecked;

  Activity currentActivity;

  Future<void> save(BuildContext context) async {
    throwIfDoubleIsZero(price(), 'Informe o preço');
    throwIf(archive.isNullOrEmpty(), 'Retire uma fotografia');

    await serviceNotifier.insert_Measurement_PriceComparisonLinesModel(
        price(), archive.imageBase64);
    goop_LibComponents.navigatorPop(context);
  }

  @override
  void didChangeDependencies() {
    if (didChangeDependenciesLoad) return;
    super.didChangeDependencies();

    currentActivity = serviceNotifier.currentActivity;

    if (currentActivity.measurementPriceComparisonLinesModel != null)  {
        archive.imageBase64 = currentActivity.measurementPriceComparisonLinesModel.photo;
        _priceController.text = currentActivity.measurementPriceComparisonLinesModel.price.toString();
    }
  }

  Widget build(BuildContext context) {
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
                    goop_LibComponents.getInputTextFormField(
                      '',
                      _priceController,
                      keyboardType: TextInputType.number,
                      readOnly: currentActivity.isChecked,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter()
                      ],
                      autoFocus: false,
                      textAlign: TextAlign.center,
                      border: false,
                    ),
                    paddingT(20),
                    imagePhotoBase64(archive, editing: editing()),
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
