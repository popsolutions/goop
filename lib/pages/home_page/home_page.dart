import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goop/config/routes.dart';
import 'package:goop/models/models.dart';
import 'package:goop/pages/components/StateGoop.dart';
import 'package:goop/pages/components/goop_button.dart';
import 'package:goop/pages/components/goop_drawer.dart';
import 'package:goop/utils/global.dart';
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

class _HomePageState extends StateGoop<HomePage> {
  LatLng userLocation;
  var locationMap;
  var missionLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    missionLocation = ModalRoute.of(context).settings.arguments;
    if (missionLocation == null) {
      locationMap = userLocation;
    }
  }

  @override
  Widget build(BuildContext context) {
    final serviceNotifier =
        Provider.of<ServiceNotifier>(context, listen: false);

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
        future: serviceNotifier.init(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<ServiceNotifier>(builder:
                (BuildContext context, ServiceNotifier value, Widget child) {
              ServiceNotifier _serviceNotifier =
                  Provider.of<ServiceNotifier>(context, listen: false);

              if (_serviceNotifier.geoLocationOk == false)
                return geoLocationError();
              else
                return FlutterMap(
                  // mapController: controller,
                  options: MapOptions(
                    center: missionLocation == null
                        ? globalGeoLocService.latLng()
                        : LatLng(missionLocation[0], missionLocation[1]),
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
                                _serviceNotifier
                                        .currentMissionModelEstablishment =
                                    missionModelEstablishment;

                                navigatorPopAndPushNamed(Routes.mission_home);
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
            });
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

  Widget geoLocationError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'Falha ao obter localização do GPS. Verifique se seu GPS está ativo e se o Goop tem permissão para acessar o GPS'),
          GoopButton(
            text: 'Abrir configurações do GPS',
            showCircularProgress: true,
            action: () async {
              Geolocator.openLocationSettings();
            },
          ),
          GoopButton(
            text: 'Tentar novamente',
            showCircularProgress: true,
            action: () async {
              await globalGeoLocService.update(context, true);
              serviceNotifier.notifyListeners();
            },
          ),
          paddingT(20),
          GoopButton(
            text: 'Fechar Goop',
            showCircularProgress: true,
            action: () async {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
}
