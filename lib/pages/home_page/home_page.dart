import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:goop/services/ServiceNotifier.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final serviceNotifier = Provider.of<ServiceNotifier>(context);
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
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(53, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 40,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(child: FlutterLogo()),
              ),
              Marker(
                width: 80,
                height: 80.0,
                point: LatLng(53, -0.06),
                builder: (ctx) => Container(child: FlutterLogo()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
