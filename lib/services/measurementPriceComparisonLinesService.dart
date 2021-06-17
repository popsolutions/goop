import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurementPriceComparisonLines.dart';

import 'constants.dart';

class MeasurementPriceComparisonLinesService{
  final Odoo _odoo = Odoo();

  Future<MeasurementPriceComparisonLinesModel> getMeasurementPriceComparisonLinesModel(int id) async {
    final response = await _odoo.searchRead(
      Strings.popsMeasurementPrice_comparisonLines,
      [
        ['id', '=', id]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    return MeasurementPriceComparisonLinesModel.fromJson(json[0]);
  }

  Future<MeasurementPriceComparisonLinesModel> getMeasurementPriceComparisonLinesModelFromMeasurementAndActivity(MeasurementModel measurementModel, Activity activity) async {
    return await getMeasurementPriceComparisonLinesModelFromMeasurementAndActivityById(measurementModel.id, activity.product_id);
  }

  Future<MeasurementPriceComparisonLinesModel> getMeasurementPriceComparisonLinesModelFromMeasurementAndActivityById(int measurementId, int product_id) async {
    final response = await _odoo.searchRead(
      Strings.popsMeasurementPrice_comparisonLines,
      [
        ["measurement_id", "in", [measurementId]],
        ["product_id", "in", [product_id]]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    return MeasurementPriceComparisonLinesModel.fromJson(json[0]);
  }


  Future<MeasurementPriceComparisonLinesModel> insertAndGet(MeasurementPriceComparisonLinesModel measurementPriceComparisonLinesModel) async {
    int id = await insert(measurementPriceComparisonLinesModel);

    MeasurementPriceComparisonLinesModel measurementPriceComparisonLinesModelInserted = await getMeasurementPriceComparisonLinesModel(id);

    if (measurementPriceComparisonLinesModelInserted == null)
      throw 'MeasurementModel Price Comparison Insert get Fail';

    return measurementPriceComparisonLinesModelInserted;
  }

  Future<int> insert(MeasurementPriceComparisonLinesModel measurementPriceComparisonLinesModel) async {
    final response = await _odoo.create(Strings.popsMeasurementPrice_comparisonLines, measurementPriceComparisonLinesModel.toJson());

    if (response.getStatusCode() == 200){
      return response.getResult(); //return id of MeasurementPriceComparisonLine
    } else {
      throw 'MeasurementPriceComparisonLine quizz lines Insert fail';
    }
  }

}