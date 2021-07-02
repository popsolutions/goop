import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:goop/services/GeoLocService.dart';

main(){
  GeoLocService geoLocService = GeoLocService();
  
  test('GeoLocService.currentLatitude', () async {
    await geoLocService.update(null);

    print(geoLocService.currentLocationStr());
  });

  test('GeoLocService.distancia', () async {
    print(geoLocService.distanceBetweenInMeter(-22.47684070345498, -48.568472933867604, -22.465792292604263, -48.56307185429291));
  });
}