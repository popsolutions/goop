import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/pages/components/libComponents.dart';
import 'package:goop/utils/goop_colors.dart';
import 'package:goop/utils/goop_images.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:goop/services/ServiceNotifier.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final serviceNotifier = Provider.of<ServiceNotifier>(context);
    final controller = MapController();

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
      body: FutureBuilder(
        future: serviceNotifier.init(),
        builder: (context, snapshot) {
          final _serviceNotifier = Provider.of<ServiceNotifier>(context);

          if (snapshot.connectionState == ConnectionState.done) {
            return FlutterMap(
              mapController: controller,
              options: MapOptions(
                center: LatLng(-23.553583043580996, -46.65204460659839),
                interactiveFlags:
                    InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                zoom: 13.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayerOptions(
                  markers: [
                    for (MissionModel missionModel
                        in _serviceNotifier.listMissionModel)
                      Marker(
                        width: 40,
                        height: 80.0,
                        point: LatLng(
                            missionModel.establishmentModel.latitude ?? 0,
                            missionModel.establishmentModel.longitude ?? 0),
                        builder: (ctx) => Container(
                          child: SvgPicture.asset(GoopImages.local),
                        ),
                      )
                  ],
                ),
              ],
            );
          } else {
            return CircularProgressIndicator(
              strokeWidth: 3,
              color: GoopColors.red,
            );
          }
        },
      ),
    );
  }
}
