import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goop/services/ServiceNotifier.dart';
import 'package:goop/pages/components/libComponents.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:provider/provider.dart';

abstract class StateGoop<T extends StatefulWidget> extends State<T> {
  ServiceNotifier serviceNotifier;

  @override
  void didChangeDependencies() {
    serviceNotifier = Provider.of<ServiceNotifier>(context, listen: false);
  }

  showProgressDialog([String caption = 'Aguarde por favor...']){
    LibComponents.showProgressDialog(context, caption);
  }

  Future<void>dialogProcess(Function function, [String caption = 'Aguarde por favor...']) async {
    await LibComponents.dialogProcess(context, function, caption);
  }

  showMessage(String title, String message) async {
    LibComponents.showMessage(context, title, message);
  }

  showSnackBar(String _text, Color _backgroundColor){
    LibComponents.showSnackBar(context, _text, _backgroundColor);
  }
}