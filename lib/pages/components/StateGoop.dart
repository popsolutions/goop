import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';

abstract class StateGoop<T extends StatefulWidget> extends State<T> {
  bool listenServiceNotifier = false;
  ServiceNotifier serviceNotifier;
  double mediaQuery;

  @override
  void didChangeDependencies() {
    serviceNotifier =
        Provider.of<ServiceNotifier>(context, listen: listenServiceNotifier);
    mediaQuery = MediaQuery.of(context).size.width;
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

  showSnackBar(String _text, Color _backgroundColor) {
    goop_LibComponents.showSnackBar(context, _text, _backgroundColor);
  }

  Padding paddingZ() => Padding(padding: EdgeInsets.only(top: 0));
  Padding paddingT(double _top) => Padding(padding: EdgeInsets.only(top: _top));

  Future<String> getPhotoBase64() async {
    return await goop_LibComponents.getPhotoBase64(context, mediaQuery);
  }

  Widget circularImageBase64(String imageBase64, {Function onTap, String defaultImage = GoopImages.avatar}) {
    return goop_LibComponents.circularImageBase64(imageBase64, onTap);
  }

  setState_() => setState(() {});
}
