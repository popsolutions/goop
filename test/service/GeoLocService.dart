import 'package:flutter_test/flutter_test.dart';
import 'package:goop/services/GeoLocService.dart';

main(){
  GeoLocService geoLocService = GeoLocService();
  
  test('GeoLocService.currentLatitude', () async {
    await geoLocService.update(null);

    print(geoLocService.currentLocationStr());
    print('x');
  });
}