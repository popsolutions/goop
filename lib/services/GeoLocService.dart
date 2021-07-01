import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';
import 'package:latlong2/latlong.dart';

class GeoLocService{
  Position position;

  double latitude() => position.latitude;
  double longitude() => position.longitude;

  String currentLocationStr() => 'Latitude:' + latitude().toString() + ' Longitude:' + longitude().toString();

  update([BuildContext context = null, bool getCurrentPosition = false]) async {
    bool _serviceEnabled;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      globalServiceNotifier.geoLocationOk = false;

      throw 'Falha ao obter localização do GPS. Verifique se seu GPS está ativo e se o Goop tem permissão para acessar o GPS';
    }

    if (_serviceEnabled) {
        await goop_LibComponents.dialogProcess(context, () async {
          if (getCurrentPosition == true) {
            position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.medium, forceAndroidLocationManager: true, timeLimit: Duration(seconds: 15));
          } else {
            position = await Geolocator.getLastKnownPosition();
          }
        }, 'Acessando GPS', 'Excedido o tempo de espera do GPS. Verifique se o seu GPS está funcionando corretamente.');


        if ((position == null) || ((position.latitude == 0) || (position.longitude == 0))) {
          globalServiceNotifier.geoLocationOk = false;
        } else {
          if (!globalServiceNotifier.geoLocationOk)
            globalServiceNotifier.geoLocationOk = true;
        }

    } else {
      throw 'Serviço de GPS está inativo.';
    }
  }

  LatLng latLng() => LatLng(latitude(), longitude());

}