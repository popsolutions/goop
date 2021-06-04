import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/AlternativeModel.dart';

import 'constants.dart';

class AlternativeService{
  //model:pops.alternative

  final Odoo _odoo = Odoo();

  Future<List<AlternativeModel>> getAlternativeService() async {
    final response = await _odoo.searchRead(Strings.popsAlternative, [], [],);
    final List json = response.getRecords();
    final listAlternativeModel = json.map((e) => AlternativeModel.fromJson(e)).toList();

    return listAlternativeModel;
  }

}