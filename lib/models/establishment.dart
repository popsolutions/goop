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

    try {
      id = jGetInt('id');
      name = jGetStr('name');
      address = jGetStr('address');
      zipCode = jGetStr('zip_code');
      latitude = jGetDouble('latitude');
      longitude = jGetDouble('longitude');

      if (latitude < -90 || latitude > 90) {
        throw 'A latitude precisa ser valor entre -90 e +90 graus. Atualmente está: $latitude';
      } else if (longitude < -180 || longitude > 180) {
        throw 'A longitude precisa ser valor entre -180 e +180 graus. Atualmente está: $longitude';
      }
    } catch (e) {
      throw 'Erro no cadastro do estabelecimento "$id-$name":\n${e.toString()}';
    }
  }
}
