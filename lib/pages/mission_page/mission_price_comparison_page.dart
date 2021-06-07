import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/AlternativeModel.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

class MissionPriceComparisionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);

    final TextStyle theme = Theme.of(context).textTheme.headline2;

    Future<void> selectQuestion(AlternativeModel selectedAlternativeModel) async{
      try {
        await serviceNotifier.insert_Measurement_quizzlinesModel(selectedAlternativeModel);
      }catch(err){
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
                      child: Divider(
                        color: Colors.deepPurple,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .65,
                      child: Text(
                        serviceNotifier.currentActivity.name,
                        style: theme,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),

                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: serviceNotifier.listAlternativeModel.length,
                        itemBuilder: (_, index) {
                          AlternativeModel currentAlternativeModel = serviceNotifier.listAlternativeModel[index];
                          return GestureDetector(
                              onTap: () async {
                                await selectQuestion(currentAlternativeModel);
                              },
                              child: Container(padding: EdgeInsets.only(top:10), child: Text(serviceNotifier.listAlternativeModel[index].name)));
                        }),
                    SizedBox(height: 30),
                    GoopTextFormField(
                      hintText: 'Resposta aqui',
                    ),
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
