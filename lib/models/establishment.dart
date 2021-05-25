import 'package:goop/models/user_profile.dart';

class EstablishmentModel {
  String name;
  String address;
  String latitude;
  String longitude;

  EstablishmentModel({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory EstablishmentModel.fromJson(Map<String, dynamic> map) {
    return EstablishmentModel(
      name: valueOrNull(map['name']),
      address: valueOrNull(map['address']),
      latitude: valueOrNull(map['latitude']),
      longitude: valueOrNull(map['longitude']),
    );
  }
}
