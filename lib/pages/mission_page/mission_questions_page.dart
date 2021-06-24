import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/libComponents.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

class MissionQuestionPage extends StatefulWidget {
  @override
  _MissionQuestionPageState createState() => _MissionQuestionPageState();
}

class _MissionQuestionPageState extends State<MissionQuestionPage> {
  int value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context, listen: false);
    QuizzLinesModel quizzLinesModel;
    Activity currentActivity = serviceNotifier.currentActivity;
    final TextStyle theme = Theme.of(context).textTheme.headline2;

    if ((value == null) && (currentActivity.isChecked ==  true))
      value = currentActivity.listQuizzLinesModelIndexSelected();

    Future<void> selectQuestion(QuizzLinesModel quizzLinesModel) async {
      try {
        await serviceNotifier
            .insert_Measurement_quizzlinesModel(quizzLinesModel);
      } catch (err) {
        //??-pedro-verificar com pedro se já tem alguma maneira de exibir o erro em tela.
        print(err);
      }
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
                            if (currentActivity.isChecked)
                              return;

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
                          action: () async {
                            if (value == null) {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: StadiumBorder(),
                                  backgroundColor: GoopColors.red,
                                  content: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Selecione uma alternativa!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              await selectQuestion(currentActivity.listQuizzLinesModel[value]);
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  shape: StadiumBorder(),
                                  backgroundColor: GoopColors.neutralGreen,
                                  content: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Pergunta Registrada! 😉',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
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
