import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: FlutterMap(
        options: MapOptions(
          //center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                //point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),

      // Container(
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
