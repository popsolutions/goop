import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goop/pages/components/goop_libComponents.dart';
import 'package:goop/utils/GoopClass.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';
import 'package:latlong2/latlong.dart';

class GeoLocService extends GoopClass{
  Position position;

  double latitude() => position.latitude;
  double longitude() => position.longitude;

  String currentLocationStr() =>
      'Latitude:' +
      latitude().toString() +
      ' Longitude:' +
      longitude().toString();

  String currentPositionStr() => (position == null)? 'Position = Null':
     'Position : \n'
    'longitude: ${position.longitude} \n'
    'latitude: ${position.latitude} \n'
    'timestamp: ${position.timestamp} \n'
    'accuracy: ${position.accuracy} \n'
    'altitude: ${position.altitude} \n'
    'heading: ${position.heading} \n'
    'floor: ${position.floor} \n'
    'speed: ${position.speed} \n'
    'speedAccuracy: ${position.speedAccuracy} \n'
    'isMocked: ${position.isMocked}';

  update([BuildContext context = null, bool getCurrentPosition = false]) async {
    if (context == null) context = globalServiceNotifier.currentBuildContext;

    bool _serviceEnabled;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_serviceEnabled) {
      globalServiceNotifier.geoLocationOk = false;

      throwG('Falha ao obter localização do GPS. Verifique se seu GPS está ativo e se o Goop tem permissão para acessar o GPS', 'update');
    }

    if (_serviceEnabled) {
      await goop_LibComponents.dialogProcess(context, () async {
        if (getCurrentPosition == true) {
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.medium,
              forceAndroidLocationManager: true,
              timeLimit: Duration(seconds: globalConfig.gpsTimeOutSeconds1));
        } else {
          position = await Geolocator.getLastKnownPosition();
        }
      }, caption: 'Acessando GPS',
         exceptionMessage: 'Excedido o tempo de espera do GPS. Verifique se o seu GPS está funcionando corretamente.',
        timeOutSeconds: globalConfig.gpsTimeOutSeconds2,
        timeOutMessage: 'Tempo de espera do GPS excedido. Verifique se o seu GPS está funcionando corretamente.'
      );

      if ((position == null) ||
          ((position.latitude == 0) || (position.longitude == 0))) {
        globalServiceNotifier.geoLocationOk = false;
      } else {
        if (!globalServiceNotifier.geoLocationOk)
          globalServiceNotifier.geoLocationOk = true;
      }
    } else {
      throwG('Serviço de GPS está inativo.', 'update');
    }

    printL('::GeoLocService.update:');
    printL(currentPositionStr());

  }

  double distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  double distanceBetweenInMeter(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    double discanteinMeters =  Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);

    printL('::GeoLocService.distanceBetweenInMeter: ');
    printL('startLatitude: $startLatitude');
    printL('startLongitude: $startLongitude');
    printL('endLatitude: $endLatitude');
    printL('endLongitude: $endLongitude');
    printL('discanteinMeters: $discanteinMeters');

    return discanteinMeters;
  }

  LatLng latLng() => LatLng(latitude(), longitude());
}
