import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/mission_dto.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

class MissionQuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle theme = Theme.of(context).textTheme.headline2;
    final MissionDto missionDto = ModalRoute.of(context).settings.arguments;
    final provider = Provider.of<ServiceNotifier>(context);
    final currentActivity = provider.currentActivity;

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
                  GoopTextFormField(
                    hintText: 'R\$ 100',
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
    );
  }
}
