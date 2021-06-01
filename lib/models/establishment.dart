import 'package:goop/models/user_profile.dart';

class EstablishmentModel {
  int id;
  String name;
  String address;
  String latitude;
  String zipCode;
  String state;
  String longitude;

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
      latitude: valueOrNull(map['latitude']),
      longitude: valueOrNull(map['longitude']),
    );
  }
}
