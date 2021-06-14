import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurementPhotoLines.dart';
import 'constants.dart';

class MeasurementPhotoLinesService{
  final Odoo _odoo = Odoo();

  Future<MeasurementPhotoLinesModel> getMeasurementPhotoLinesModelById(int id) async {
    final response = await _odoo.searchRead(
      Strings.measurement_photoLine,
      [
        ['id', '=', id]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    return MeasurementPhotoLinesModel.fromJson(json[0]);
  }

  Future<MeasurementPhotoLinesModel> getMeasurementPhotoLinesFromMeasurementAndActivity(MeasurementModel measurementModel, Activity activity) async {
    return await getMeasurementPhotoLinesFromMeasurementAndActivityById(measurementModel.id, activity.id);
  }

  Future<MeasurementPhotoLinesModel> getMeasurementPhotoLinesFromMeasurementAndActivityById(int measurementId, int photoLinesId) async {
    final response = await _odoo.searchRead(
      Strings.measurement_photoLine,
      [
        ["measurement_id", "in", [measurementId]],
        ["photo_id", "in", [photoLinesId]]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    return MeasurementPhotoLinesModel.fromJson(json[0]);
  }




  Future<MeasurementPhotoLinesModel> insertAndGet(MeasurementPhotoLinesModel measurementPhotoLinesModel) async {
    int id = await insert(measurementPhotoLinesModel);

    MeasurementPhotoLinesModel measurementPhotoLinesModelInserted = await getMeasurementPhotoLinesModelById(id);

    if (measurementPhotoLinesModelInserted == null)
      throw 'MeasurementModel quizz lines Insert get Fail';

    return measurementPhotoLinesModelInserted;
  }

  Future<int> insert(MeasurementPhotoLinesModel measurementPhotoLinesModel) async {
    final response = await _odoo.create(Strings.measurement_photoLine, measurementPhotoLinesModel.toJson());

    if (response.getStatusCode() == 200){
      return response.getResult(); //return id of Measurement_quizzlinesModel
    } else {
      throw 'MeasurementModel quizz lines Insert fail';
    }
  }


}