import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/measurement_quizzlines.dart';

import 'constants.dart';

class Measurement_quizzlinesService{
  final Odoo _odoo = Odoo();

  Future<Measurement_quizzlinesModel> getMeasurement_quizzlinesModelModelById(int id) async {
    final response = await _odoo.searchRead(
      Strings.measurement_quizzlines,
      [
        ['id', '=', id]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    return Measurement_quizzlinesModel.fromJson(json[0]);
  }

  Future<Measurement_quizzlinesModel> insertAndGet(Measurement_quizzlinesModel measurement_quizzlinesModel) async {
    int id = await insert(measurement_quizzlinesModel);

    Measurement_quizzlinesModel measurementModelInserted = await getMeasurement_quizzlinesModelModelById(id);

    if (measurementModelInserted == null)
      throw 'MeasurementModel quizz lines Insert get Fail';

    return measurementModelInserted;
  }


  Future<int> insert(Measurement_quizzlinesModel measurement_quizzlinesModel) async {
    final response = await _odoo.create(Strings.measurement_quizzlines, measurement_quizzlinesModel.toJson());

    if (response.getStatusCode() == 200){
      return response.getResult(); //return id of Measurement_quizzlinesModel
    } else {
      throw 'MeasurementModel quizz lines Insert fail';
    }
  }

}