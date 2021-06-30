import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/models.dart';
import 'package:goop/pages/components/goop_drawer.dart';
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
  LatLng userLocation;
  bool _serviceEnabled;

  Future _getCurrentLocation() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sem acesso a localização!"),
            content:
                const Text('Para continuar a usar o app habilite seu GPS.'),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                  setState(() {});
                },
              )
            ],
          );
        },
      );
    }

    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.lowest,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(() {
        userLocation = LatLng(
          position.latitude,
          position.longitude,
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final serviceNotifier =
        Provider.of<ServiceNotifier>(context, listen: false);
    var missionLocation = ModalRoute.of(context).settings.arguments;
    print(missionLocation);

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
          final _serviceNotifier =
              Provider.of<ServiceNotifier>(context, listen: false);

          if (snapshot.connectionState == ConnectionState.done) {
            return FlutterMap(
              // mapController: controller,
              options: MapOptions(
                center: LatLng(-23.553583043580996, -46.65204460659839),
                // center: userLocation,
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
                    for (MissionModelEstablishment missionModelEstablishment
                        in _serviceNotifier.listMissionModelEstablishment)
                      Marker(
                        width: 40,
                        height: 80.0,
                        point: LatLng(
                          missionModelEstablishment
                                  .establishmentModel.latitude ??
                              0,
                          missionModelEstablishment
                                  .establishmentModel.longitude ??
                              0,
                        ),
                        builder: (ctx) => GestureDetector(
                          onTap: () {
                            // if (missionModelEstablishment.listMissionModel.length == 0){
                            _serviceNotifier.viewByEstablishment = true;
                            _serviceNotifier.currentMissionModelEstablishment =
                                missionModelEstablishment;

                            Navigator.popAndPushNamed(
                              context,
                              Routes.mission_home,
                            );
                            // }
                          },
                          child: Container(
                            child: SvgPicture.asset(GoopImages.local),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                // color: GoopColors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
