import 'package:goop/models/absModels.dart';
import 'package:goop/utils/utils.dart';

class EstablishmentModel extends AbsModels {
  int id;
  String name;
  String address;
  double latitude;
  String zipCode;
  String state;
  double longitude;

  EstablishmentModel({
    this.id,
    this.name,
    this.address,
    this.zipCode,
    this.latitude,
    this.longitude,
  });

  EstablishmentModel.fromJson(Map<String, dynamic> map) {
    currentJson = map;

    id = jGetInt('id');
    name = jGetStr('name');
    address = jGetStr('address');
    zipCode = jGetStr('zip_code');
    latitude = jGetDouble('latitude');
    longitude = jGetDouble('longitude');
  }
}
