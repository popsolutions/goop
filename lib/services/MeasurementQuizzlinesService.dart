import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/models/quizzLinesModel.dart';

import 'constants.dart';

class MeasurementQuizzlinesService{
  final Odoo _odoo = Odoo();

  Future<MeasurementQuizzlinesModel> getMeasurementQuizzLinesFromMeasurementAndActivity(MeasurementModel measurementModel, Activity activity) async {
    return getMeasurementQuizzLinesFromMeasurementIdAndQuizLinesId(measurementModel.id, activity.id);
  }

  Future<MeasurementQuizzlinesModel> getMeasurementQuizzLinesFromMeasurementIdAndQuizLinesId(int MeasurementId, int quizLinesId) async {
    final response = await _odoo.searchRead(
      Strings.measurement_quizzlines,
      [
        ["measurement_id", "in", [MeasurementId]],
        ["quizz_id", "in", [quizLinesId]]
      ],
      [],
    );
    final List json = response.getRecords();

    if (json.length == 0) return null;
    final measurementQuizzLinesModel = MeasurementQuizzlinesModel.fromJson(json[0]);

    return measurementQuizzLinesModel;
  }


  Future<MeasurementQuizzlinesModel> getMeasurement_quizzlinesModelModelById(int id) async {
    final response = await _odoo.searchRead(
      Strings.measurement_quizzlines,
      [
        ['id', '=', id]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    return MeasurementQuizzlinesModel.fromJson(json[0]);
  }

  Future<MeasurementQuizzlinesModel> insertAndGet(MeasurementQuizzlinesModel measurement_quizzlinesModel) async {
    int id = await insert(measurement_quizzlinesModel);

    MeasurementQuizzlinesModel measurementModelInserted = await getMeasurement_quizzlinesModelModelById(id);

    if (measurementModelInserted == null)
      throw 'MeasurementModel quizz lines Insert get Fail';

    return measurementModelInserted;
  }


  Future<int> insert(MeasurementQuizzlinesModel measurement_quizzlinesModel) async {
    final response = await _odoo.create(Strings.measurement_quizzlines, measurement_quizzlinesModel.toJson());

    if (response.getStatusCode() == 200){
      return response.getResult(); //return id of Measurement_quizzlinesModel
    } else {
      throw 'MeasurementModel quizz lines Insert fail';
    }
  }

}