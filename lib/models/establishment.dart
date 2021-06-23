import 'package:goop/utils/utils.dart';

class EstablishmentModel {
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

  factory EstablishmentModel.fromJson(Map<String, dynamic> map) {
    return EstablishmentModel(
      id: valueOrNull(map['id']),
      name: valueOrNull(map['name']),
      address: valueOrNull(map['address']),
      zipCode: valueOrNull(map['zip_code']),
      latitude: jsonGetdouble(map, 'latitude'),
      longitude: jsonGetdouble(map, 'longitude'),
    );
  }
}
