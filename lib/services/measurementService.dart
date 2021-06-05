import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/measurement.dart';

import 'constants.dart';

class MeasurementService {
  final Odoo _odoo = Odoo();


  Future<MeasurementModel> getMeasurementModelById(int id) async {
    final response = await _odoo.searchRead(
      Strings.meassurement,
      [
        ['id', '=', id]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    return MeasurementModel.fromJson(json[0]);
  }

  Future<MeasurementModel> insertAndGet(MeasurementModel measurementModel) async {
    int id = await insert(measurementModel);

    MeasurementModel measurementModelInserted = await getMeasurementModelById(id);

    if (measurementModelInserted == null)
      throw 'MeasurementModel Insert get Fail';

    return measurementModelInserted;
  }


  Future<int> insert(MeasurementModel measurementModel) async {
    final response = await _odoo.create(Strings.meassurement, measurementModel.toJson());

    if (response.getStatusCode() == 200){
      return response.getResult(); //return id of MeasurementModel
    } else {
      throw 'MeasurementModel Insert fail';
    }
  }



}