import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/AlternativeModel.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/ClassConstants.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

class MissionPriceComparisionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);
    Activity currentActivity = serviceNotifier.currentActivity;

    final TextStyle theme = Theme.of(context).textTheme.headline2;

    Future<void> selectQuestion(
        QuizzLinesModel quizzLinesModel) async {
      try {
        await serviceNotifier.insert_Measurement_quizzlinesModel(quizzLinesModel);
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
                      'PERGUNTA 1',
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
                      itemCount: currentActivity.listQuizzLinesModel.length,
                      itemBuilder: (_, index) {
                        QuizzLinesModel quizzLinesModel = currentActivity.listQuizzLinesModel[index];

                        return GestureDetector(
                          onTap: () async {
                            await selectQuestion(quizzLinesModel);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(quizzLinesModel.alternative_name),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30)
                  ],
                ),
                Container(
                  child: GoopButton(
                    text: 'Salvar',
                    action: () {},
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
