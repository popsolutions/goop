import 'package:goop/models/user_profile.dart';

class Establishment {
  String name;
  String address;
  String latitude;
  String longitude;

  Establishment({
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  factory Establishment.fromJson(Map<String, dynamic> map) {
    return Establishment(
      name: valueOrNull(map['name']),
      address: valueOrNull(map['address']),
      latitude: valueOrNull(map['latitude']),
      longitude: valueOrNull(map['longitude']),
    );
  }
}
