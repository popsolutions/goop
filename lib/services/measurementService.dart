import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/measurementPhotoLines.dart';
import 'package:goop/models/measurementPriceComparisonLines.dart';
import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/models/mission.dart';
import 'package:goop/services/MeasurementPhotoLinesService.dart';
import 'package:goop/services/MeasurementQuizzlinesService.dart';
import 'package:goop/services/measurementPriceComparisonLinesService.dart';
import 'package:goop/utils/global.dart';

import 'constants.dart';

class MeasurementService {
  final Odoo _odoo = Odoo();

  MeasurementQuizzlinesService measurementQuizzlinesService = new MeasurementQuizzlinesService();
  MeasurementPhotoLinesService measurementPhotoLinesService = new MeasurementPhotoLinesService();
  MeasurementPriceComparisonLinesService measurementPriceComparisonLinesService = new MeasurementPriceComparisonLinesService();

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

  Future<MeasurementModel> getMeasurementModelFromMissionAndPartner_id(MissionModel missionModel, int partner_id) async {
    return await getMeasurementModelFromMissionIdAndPartner_id(missionModel.id, partner_id);
  }

  Future<MeasurementModel> getMeasurementModelFromMissionIdAndPartner_id(int missionId, int partner_id) async {
    final response = await _odoo.searchRead(
      Strings.meassurement,
      [
        ["missions_id", "in", [missionId]],
        ["partner_id", "in", [partner_id]]
      ],
      [],
    );

    final List json = response.getRecords();
    if (json.length == 0) return null;

    return MeasurementModel.fromJson(json[0]);
  }

  Future<MeasurementQuizzlinesModel> getMeasurementQuizzLinesFromMeasurementAndActivity(MeasurementModel measurementModel, Activity activity) async {
    MeasurementQuizzlinesModel measurementQuizzlinesModel = await measurementQuizzlinesService.getMeasurementQuizzLinesFromMeasurementAndActivity(measurementModel, activity);
    return measurementQuizzlinesModel;
  }

  Future<MeasurementPhotoLinesModel> getMeasurementPhotoLinesFromMeasurementAndActivity(MeasurementModel measurementModel, Activity activity) async {
    MeasurementPhotoLinesModel measurementPhotoLinesModel = await measurementPhotoLinesService.getMeasurementPhotoLinesFromMeasurementAndActivity(measurementModel, activity);
    return measurementPhotoLinesModel;
  }

  Future<MeasurementPriceComparisonLinesModel> getmeasurementPriceComparisonLinesModelFromMeasurementAndActivity(MeasurementModel measurementModel, Activity activity) async {
    MeasurementPriceComparisonLinesModel measurementPriceComparisonLinesModel = await measurementPriceComparisonLinesService.getMeasurementPriceComparisonLinesModelFromMeasurementAndActivity(measurementModel, activity);
    return measurementPriceComparisonLinesModel;
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

  Future<bool> update(MeasurementModel measurementModel) async {
    await _odoo.write(
      Strings.meassurement,
      [measurementModel.id],
      measurementModel.toJson(),
    );

    return true;
  }

  Future<int> updateGeoLocation(MeasurementModel measurementModel, MissionModel missionModelOwner) async {
    await globalGeoLocService.update();

    double distanceMeters = globalGeoLocService.distanceBetweenInMeter(
        globalGeoLocService.latitude(),
        globalGeoLocService.longitude(),
        missionModelOwner.establishmentModel.latitude,
        missionModelOwner.establishmentModel.longitude);

    if (distanceMeters > globalConfig.distanceMetersLimitUser){
      throw 'Você não está no local da missão!';
    }

    measurementModel.measurementLatitude = globalGeoLocService.latitude();
    measurementModel.measurementLongitude = globalGeoLocService.longitude();

    update(measurementModel);
  }

  Future<bool> delete(MeasurementModel measurementModel) async {
    await _odoo.unlink(
      Strings.meassurement,
      [measurementModel.id]
    );

    return true;
  }





  }