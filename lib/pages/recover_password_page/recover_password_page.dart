import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/pages/components/goop_back.dart';
import 'package:goop/utils/global.dart';

class RecoverPasswordPage extends StatefulWidget {
  @override
  State<RecoverPasswordPage> createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  bool popExecuted = false;

  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print('*** url:' + url);
      if (url != globalConfig.serverURLRegisterPage) {
        if (popExecuted) return;

        print('*** url--- POP');
        Navigator.pushNamed(context, Routes.login);
        popExecuted = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TextStyle style(double fontSize) {
    //   return TextStyle(
    //     fontFamily: 'RobotoCondensed',
    //     fontSize: fontSize,
    //     fontWeight: FontWeight.bold,
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GoopBack(),
        title: Text('Esqueci minha senha'),
        centerTitle: true,
      ),
      body:
          WebviewScaffold(url: 'https://dev.charismabi.com/web/reset_password'),
      // body: Center(
      //   child: Container(
      //     width: MediaQuery.of(context).size.width * .8,
      //     child: SingleChildScrollView(
      //       child: Column(
      //         children: [
      //           Container(
      //             height: 200,
      //             child: SvgPicture.asset(GoopImages.recover_password),
      //           ),
      //           Text(
      //             'Recuperar Senha',
      //             style: style(25),
      //           ),
      //           Text(
      //             'Por Favor, digite o seu e-mail abaixo',
      //             style: style(18),
      //           ),
      //           SizedBox(height: 30),
      //           GoopTextFormField(hintText: "E-mail"),
      //           GoopButton(
      //             text: 'Enviar',
      //             action: () {},
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
