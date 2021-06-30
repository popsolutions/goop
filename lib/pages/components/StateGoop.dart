import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:goop/utils/utils.dart';
import 'package:provider/provider.dart';

abstract class StateGoop<T extends StatefulWidget> extends State<T> {
  bool didChangeDependenciesLoad = false;
  bool listenServiceNotifier = false;
  ServiceNotifier serviceNotifier;
  double mediaQuery;
  TextStyle theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (didChangeDependenciesLoad == true) return;
    serviceNotifier =
        Provider.of<ServiceNotifier>(context, listen: listenServiceNotifier);
    mediaQuery = MediaQuery.of(context).size.width;
    theme = Theme.of(context).textTheme.headline2;

    didChangeDependenciesLoad = true;
  }

  showProgressDialog([String caption = 'Aguarde por favor...']) {
    goop_LibComponents.showProgressDialog(context, caption);
  }

  Future<void> dialogProcess(Function function,
      [String caption = 'Aguarde por favor...']) async {
    await goop_LibComponents.dialogProcess(context, function, caption);
  }

  showMessage(String title, String message) async {
    await goop_LibComponents.showMessage(context, title, message);
  }

  showMessageOps(String message) async {
    await goop_LibComponents.showMessage(context, 'Opps', message);
    throw message;
  }

  showSnackBar(String _text, Color _backgroundColor) {
    goop_LibComponents.showSnackBar(context, _text, _backgroundColor);
  }

  Padding paddingZ() => Padding(padding: EdgeInsets.only(top: 0));
  Padding paddingT(double _top) => Padding(padding: EdgeInsets.only(top: _top));

  Future<String> getPhotoBase64() async {
    return await goop_LibComponents.getPhotoBase64(context, mediaQuery);
  }

  Widget imagePhotoBase64(ImageGoop imageBase64,
      {Function onTap,
      String defaultImage = GoopImages.avatar,
      bool editing = true}) {
    return goop_LibComponents.imagePhotoBase64(
        imageBase64.imageBase64,
        (onTap != null)
            ? onTap
            : () async {
                if (!editing) return null;

                String fileBase64 = await getPhotoBase64();

                if (fileBase64 != null) imageBase64.imageBase64 = fileBase64;

                setState_();
              });
  }

  setState_() => setState(() {});

  throwIf(bool value, String message) {
    if (value == true) throw message;
  }

  throwIfDoubleIsZero(double value, String message) => throwIf(value == 0, message);

  navigatorPop(){
    goop_LibComponents.navigatorPop(context);
  }

  navigatorPopAndPushNamed(String route){
    goop_LibComponents.navigatorPopAndPushNamed(
      context,
      route,
    );
  }

  pushNamedAndRemoveUntil(String route, RoutePredicate predicate, {Object arguments}) {
    goop_LibComponents.pushNamedAndRemoveUntil(
        context,
        route,
        predicate,
        arguments: arguments
    );
  }

  navigatorPushNamed(String route, {Object arguments}){
    goop_LibComponents.navigatorPushNamed(context, route, arguments: arguments);
  }

  pushReplacementNamed(String route){
    goop_LibComponents.pushReplacementNamed(
        context,
        route
    );
  }
}
