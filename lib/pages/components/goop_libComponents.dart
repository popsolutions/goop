import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goop/pages/settings_page/preview_page.dart';
import 'package:goop/utils/GoopClass.dart';
import 'package:goop/utils/StackUtil.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/svg.dart';

int dialogProcessIndex = 0;

class goop_LibComponents extends GoopClass{
  static Widget paddingZ() {
    return Padding(padding: EdgeInsets.only(top: 0));
  }

  static Widget paddingT(double _top) {
    return Padding(padding: EdgeInsets.only(top: _top));
  }

  static showProgressDialog(BuildContext context,
      [String caption = 'Aguarde por favor...']) {
    AlertDialog alert = AlertDialog(
      backgroundColor: goopColors.white,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularProgressIndicator(
            backgroundColor: goopColors.red,
            valueColor: AlwaysStoppedAnimation<Color>(goopColors.white),
          ),
          SizedBox(width: 20),
          Container(
            margin: EdgeInsets.only(left: 3),
            child: Text(
              caption,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: goopColors.brown),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> dialogProcess(BuildContext context, Function function,
      {String caption = 'Aguarde por favor...', String exceptionMessage, timeOutSeconds = 0, timeOutMessage = 'Operação cancelada. Tempo de espera esgotado.',
      timeOutFunctionOrigin = ''}) async {
    void dialogProcessLog(String s) => printL2('goop_LibComponents.dialogProcess - dialogProcessIndex: $dialogProcessIndex - $s');

    showProgressDialog(context, caption);
    try {
      dialogProcessLog('Start - caption:"$caption" - exceptionMessage:"$exceptionMessage"' +
          ((timeOutSeconds == 0)? '': ' - whit timeOut timeOutSeconds:"$timeOutSeconds" - timeOutMessage:"$timeOutMessage"'));
      ++dialogProcessIndex;

        try {
          if (timeOutSeconds == 0) {
            await function();
          }else {
            await Future(() => function()).timeout(Duration(seconds: timeOutSeconds), onTimeout: (){
              dialogProcessLog('TimeOut exception - timeOutSeconds:"$timeOutSeconds" - timeOutMessage:"$timeOutMessage"');
              throw FormatException(timeOutMessage, timeOutFunctionOrigin);
            });
          }

        } finally {
          --dialogProcessIndex;
          dialogProcessLog('finally');
          goop_LibComponents.navigatorPop(context, null, false);
        }

    } catch (e) {
      String eMessage;

      if (e is FormatException) {
        dialogProcessLog('Catch exception - Source:"${e.source}", message:"${e.message}"');
        eMessage = e.message;
      } else {
        eMessage = e.toString();
        dialogProcessLog('Catch exception - message:"${eMessage}"');
      }

      if (exceptionMessage == null) exceptionMessage = eMessage;

      if (dialogProcessIndex == 0) {
        showMessage(context, 'Opss', exceptionMessage);
        throw '';
      } else {
        if (exceptionMessage != null)
          throw exceptionMessage;
        else
          throw e;
      }
    }
  }

  static showMessage(BuildContext context, String title, String message) async {
    printL2('goop_LibComponents.showMessage - title: "$title", message:"$message"');

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctxt) {
          return AlertDialog(
            backgroundColor: goopColors.white ,
            title: Text(
              title,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: goopColors.black,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18,
                color: goopColors.black,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  navigatorPop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext ctxt) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: goopColors.black,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18,
                color: goopColors.black,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  navigatorPop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  static showSnackBar(
      BuildContext context, String _text, Color _backgroundColor,
      [int _milliseconds = 2000]) {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: StadiumBorder(),
          duration: Duration(milliseconds: _milliseconds),
          backgroundColor: _backgroundColor,
          content: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              _text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }catch(e){
      printL(e.toString());
    }
  }

  static Widget getInputTextFormField(
      String _label, TextEditingController _controller,
      {int maxLength,
      bool required = true,
      bool readOnly = false,
      keyboardType = TextInputType.text,
      List<TextInputFormatter> inputFormatters,
      TextStyle textStyle,
      bool autoFocus = false,
      Function onTap,
      bool border = false,
      Color borderColor,
      TextAlign textAlign = TextAlign.start}) {
    if (borderColor == null) borderColor = goopColors.teal;

    if (textStyle == null){
      textStyle = TextStyle(color: goopColors.black);
    }

    return TextFormField(
      autofocus: autoFocus,
      readOnly: readOnly,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,

      decoration: InputDecoration(
          border: (border)
              ? new OutlineInputBorder(
                  borderSide: new BorderSide(color: borderColor))
              : null,
          labelText: _label,
          suffixIcon: IconButton(
            onPressed: () => _controller.clear(),
            icon: Icon(Icons.clear, color: goopColors.red),
          )),
      style: textStyle,
      controller: _controller,
      maxLength: maxLength,
      textAlign: textAlign,
      onTap: onTap,
      onFieldSubmitted: (v) {},
      validator: (value) {
        if ((required) && (value.isEmpty))
          return "Campo obrigatório, por favor informe o valor solicitado.";
        return null;
      },
    );
  }

  static Future<String> showPreview(BuildContext context, File file) async {
    String fileBase64;
    file = await navigatorPush(
      context,
      MaterialPageRoute(builder: (_) => PreviewPage(file)),
    );

    if (file != null) {
      fileBase64 = base64Encode(file.readAsBytesSync());
    }

    navigatorPop(context);
    return fileBase64;
  }

  static Future<String> getFileFromGallery() async {
    final picker = ImagePicker();
    String fileBase64;

    final PickedFile file = await picker.getImage(source: ImageSource.gallery);
    File fileTmp = File(file.path);

    if (file != null) {
      fileBase64 = base64Encode(fileTmp.readAsBytesSync());
    }

    return fileBase64;
  }

  static Future<String> getPhotoBase64(
      BuildContext context, double mediaQuery) async {
    String fileBase64;

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return Container(
          color: goopColors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                height: 3,
                width: 60,
                color: goopColors.grey,
              ),
              Container(
                width: mediaQuery * .5,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Tire uma foto.'),
                  style: ElevatedButton.styleFrom(
                    primary: goopColors.redSplash,
                    onPrimary: goopColors.white,
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CameraCamera(
                          enableZoom: true,
                          resolutionPreset: ResolutionPreset.medium,
                          onFile: (file) async {
                            fileBase64 = await showPreview(context, file);
                            navigatorPop(context);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: mediaQuery * .5,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.attach_file_outlined),
                  label: Text('Escolha um arquivo'),
                  style: ElevatedButton.styleFrom(
                    primary: goopColors.redSplash,
                    onPrimary: goopColors.white,
                  ),
                  onPressed: () async {
                    fileBase64 = await getFileFromGallery();
                    navigatorPop(context);
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                height: 30,
                child: SvgPicture.asset(GoopImages.charisma),
              ),
            ],
          ),
        );
      },
    );


    return fileBase64;
  }

  static Widget imagePhotoBase64(ImageGoop imageBase64, Function _onTap) {
    return GestureDetector(
      onTap: () async {
        await _onTap();
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: (imageBase64.isNullOrEmpty())
              ? SvgPicture.asset(
                  GoopImages.avatar,
                  height: 150,
                )
              : Image.memory(
                  imageBase64.uint8List(),
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                )),
    );
  }

  //################################################ Navigator ################################################
  static Future<T> navigatorPop<T extends Object>(BuildContext context, [T result, bool popStack = true]) {
    globalScreenStackPop('navigatorPop', popStack);

    Navigator.pop(context, result);
  }

  static Future<T> navigatorPopAndPushNamed<T extends Object>(BuildContext context, String route, {Object arguments}) {
    globalScreenStackPop('navigatorPopAndPushNamed');
    globalScreenStackPush(route, 'navigatorPopAndPushNamed(2)');
    return Navigator.popAndPushNamed(context, route, arguments: arguments);
  }

  static Future<T> navigatorPush<T extends Object>(BuildContext context, Route<T> route) {
    globalScreenStackPush('/unknown', 'navigatorPush');

    return Navigator.push(
        context,
        route
    );
  }

  static Future<T> navigatorPushNamed<T extends Object>(BuildContext context, String route, {Object arguments}) {
    globalScreenStackPush(route, 'navigatorPushNamed');

    return Navigator.pushNamed(
      context,
      route,
      arguments: arguments
    );
  }

  static Future<T> navigatorPushNamedAndRemoveUntil<T extends Object>(BuildContext context, String route, RoutePredicate predicate, {Object arguments}) {
    globalScreenStackClear();
    globalScreenStackPush(route, 'navigatorPushNamedAndRemoveUntil');

    return Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        predicate,
        arguments: arguments
    );
  }

  static Future<T> navigatorPushNamedAndRemoveAll<T extends Object>(BuildContext context, String route, {Object arguments}) {
    globalScreenStackClear();
    globalScreenStackPush(route, 'navigatorPushNamedAndRemoveAll');

    return Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        (route) => false,
        arguments: arguments
    );
  }

  static Future<T> navigatorPushReplacementNamed<T extends Object>(BuildContext context, String route, {Object arguments}) {
    globalScreenStackPop('navigatorPushReplacementNamed');
    globalScreenStackPush(route, 'navigatorPushReplacementNamed(2)');

    return Navigator.pushReplacementNamed(
      context,
      route,
      arguments: arguments
    );
  }

  static void globalScreenStackPop(String origin, [popStack = true]){
    if (globalScreenStack.length == 0)
      navigatorLog('($origin) pop: [current zero, not pop]   ----  navigatorLogCurrentScreenTree: ' + navigatorLogCurrentScreenTree());
    else {
      if (popStack) {
        String s = globalScreenStack.pop();
        navigatorLog('($origin) pop: $s   --- navigatorLogCurrentScreenTree: ' + navigatorLogCurrentScreenTree());
      } else
        navigatorLog('($origin) pop whitout Stack   --- navigatorLogCurrentScreenTree: ' + navigatorLogCurrentScreenTree());
    }
  }

  static void globalScreenStackPush(String route, String origin){
    globalScreenStack.push(route);
    navigatorLog('($origin) push: $route   --- navigatorLogCurrentScreenTree: ' + navigatorLogCurrentScreenTree());
  }

  static void globalScreenStackClear(){
    globalScreenStack.Clear();
    navigatorLog('clear All: ');
  }

  static void navigatorLogVoid(String value){
    navigatorLog('void call: ' + value);
  }

  static String navigatorLogCurrentScreenTree(){
    String currentScreenTree = '';

    for (var i = 0; i < globalScreenStack.length; ++i){
      currentScreenTree += globalScreenStack.item(i);
    }

    return currentScreenTree;
  }

  static void navigatorLog(String value){
    printL2('*** navigatorLog *** ' + value);
  }
//################################################ Navigator ################################################

}
