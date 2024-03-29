import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/user_profile.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_images.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends StateGoop<RegisterPage> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool popExecuted = false;

  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print('*** url:' + url);
      if (url != globalConfig.serverURLRegisterPage) {
        if (popExecuted) return;

        print('*** url--- POP');
        navigatorPushReplacementNamed(Routes.login);
        popExecuted = true;
      }
    });
  }

  UserProfile userProfile = UserProfile();
  int selecionedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Container(
          width: 100,
          child: Image.asset(GoopImages.cadastro),
        ),
        centerTitle: true,
      ),
      body: WebviewScaffold(url: globalConfig.serverURLRegisterPage),

      // Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         imagePhotoBase64(userProfile.imageClass),
      //         GoopFormRegister(userProfile),
      //         RadioListTile(
      //           activeColor: GoopColors.green,
      //           value: 0,
      //           groupValue: 1,
      //           title: Text(
      //             'Sou maior de 18 anos.',
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           onChanged: (int ind) {
      //             setState(() {
      //               selecionedValue = ind;
      //             });
      //           },
      //         ),
      //         RadioListTile(
      //           activeColor: GoopColors.green,
      //           value: 0,
      //           groupValue: selecionedValue,
      //           title: Text(
      //             'Aceito os termos de uso.',
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //           onChanged: (int ind) {
      //             setState(() {
      //               selecionedValue = ind;
      //             });
      //           },
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(bottom: 40),
      //           child: GoopButton(
      //             // showCircularProgress: true,
      //             text: 'Finalizar',
      //             action: () async {
      //               void validate(String value, String caption) async {
      //                 if ((value??'') == ''){
      //                   await showMessage('Cadastro incompleto', 'informe o $caption');
      //                   throw '';
      //                 }
      //                 return;
      //               }

      //               await validate(userProfile.login, 'Login');
      //               await validate(userProfile.name, 'Nome');
      //               await validate(userProfile.cnpjCpf, 'CPF');
      //               await validate(userProfile.birthdate, 'Nascimento');
      //               await validate(userProfile.gender, 'Gênero');
      //               await validate(userProfile.email, 'E-mail');
      //               await validate(userProfile.phone , 'Celular');
      //               await validate(userProfile.zip, 'CEP');
      //               await validate(userProfile.password, 'Senha');

      //               UserServiceImpl userServiceImpl = new UserServiceImpl(Odoo());
      //               try {
      //                 await userServiceImpl.createUser(userProfile);
      //               } catch (e) {
      //                 goop_LibComponents.showMessage(context, 'Opss', e.toString());
      //               }
      //             },
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
