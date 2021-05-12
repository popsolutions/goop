import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_text_form_field.dart';
import 'package:goop/utils/goop_images.dart';

class MissionPriceComparisionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle theme = Theme.of(context).textTheme.headline2;
    

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
                        'Existe alguma geladeira Exclusiva de algumas dessas Marcas na loja?',
                        style: theme,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Preço',
                      style: Theme.of(context).textTheme.headline1,
                    ),
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
