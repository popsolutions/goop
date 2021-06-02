import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:provider/provider.dart';
import 'package:goop/services/ServiceNotifier.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceNotifier serviceNotifier = Provider.of<ServiceNotifier>(context);
    serviceNotifier.init();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: GoopColors.red),
        actions: [
          Container(
            width: 45,
            margin: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(GoopImages.red_smile),
          ),
        ],
      ),
      drawer: GoopDrawer(),
      body: Container(),

      // body: Container(
      //   height: double.infinity,
      //   width: double.infinity,
      //   child: Image.asset(
      //     //TODO: DEVERÁ SER SUBSTITUÍDO PELO MAPA REAL
      //     GoopImages.map,
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }
}
