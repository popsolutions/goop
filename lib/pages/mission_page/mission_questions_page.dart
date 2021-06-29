import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class MissionQuestionPage extends StatefulWidget {
  @override
  _MissionQuestionPageState createState() => _MissionQuestionPageState();
}

class _MissionQuestionPageState extends StateGoop<MissionQuestionPage> {
  int value;

  @override
  Widget build(BuildContext context) {
    Activity currentActivity = serviceNotifier.currentActivity;
    final TextStyle theme = Theme.of(context).textTheme.headline2;

    if ((value == null) && (currentActivity.isChecked == true))
      value = currentActivity.listQuizzLinesModelIndexSelected();

    Future<void> selectQuestion(QuizzLinesModel quizzLinesModel) async {
      await serviceNotifier.insert_Measurement_quizzlinesModel(quizzLinesModel);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          height: 40,
          child: SvgPicture.asset(GoopImages.questions),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'PERGUNTA',
                      style: theme,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      child: Divider(color: Colors.deepPurple),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .65,
                      child: Text(
                        currentActivity.name,
                        style: theme,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: currentActivity.listQuizzLinesModel.length,
                      itemBuilder: (_, index) {
                        return RadioListTile(
                          title: Text(
                            currentActivity
                                .listQuizzLinesModel[index].alternative_name,
                          ),
                          value: index,
                          groupValue: value,
                          onChanged: (int ind) {
                            if (currentActivity.isChecked) return;

                            setState(() {
                              value = ind;
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(height: 30)
                  ],
                ),
                (currentActivity.isChecked)
                    ? paddingZ()
                    : Container(
                        child: GoopButton(
                          text: 'Salvar',
                          isLoading: serviceNotifier.isLoading,
                          action: () async {
                            if (value == null) {
                              showSnackBar(
                                  'Selecione uma alternativa!', GoopColors.red);
                            } else {
                              await dialogProcess(() async {
                                await selectQuestion(
                                    currentActivity.listQuizzLinesModel[value]);
                              });
                              showSnackBar(
                                  'Pergunta Registrada! 😉', GoopColors.red);
                              Navigator.pop(context);
                            }
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
