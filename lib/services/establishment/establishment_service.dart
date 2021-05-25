import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/establishment.dart';
import 'package:goop/services/constants.dart';

class EstablishmentService {
  final Odoo _odoo;
  EstablishmentService(this._odoo);

  Future<List<EstablishmentModel>> getMissions() async {
    final response = await _odoo.searchRead(Strings.establishment, [], []);
    final json = response.getResult() as List;
    return json.map((e) => EstablishmentModel.fromJson(e)).toList();
  }
}
