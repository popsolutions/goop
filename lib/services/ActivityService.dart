import 'package:goop/models/measurement.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/models/user.dart';
import 'package:goop/services/measurementService.dart';

import '../config/http/odoo_api.dart';
import '../models/activity.dart';
import '../models/mission.dart';
import '../utils/ClassConstants.dart';
import 'QuizzLinesModelService.dart';
import 'constants.dart';

class ActivityService {
  Odoo _odoo = Odoo();

  QuizzLinesModelService quizzLinesModelService = QuizzLinesModelService();
  MeasurementService measurementService = MeasurementService();

  Future<List<Activity>> getListActivityModelFromMission(
      MissionModel missionModel, String model) async {
    String fieldMissionName = 'missions_id';

    if (model == Strings.photoLines) fieldMissionName = 'mission_id';

    final response = await _odoo.searchRead(
      model,
      [
        [
          fieldMissionName,
          'in',
          [missionModel.id]
        ]
      ],
      [],
    );
    final List json = response.getRecords();

    String activityType = '';

    if (model == Strings.photoLines) activityType = ActivityTypeConsts.Photo;
    if (model == Strings.popsQuizz) activityType = ActivityTypeConsts.Quizz;
    if (model == Strings.price_comparison)
      activityType = ActivityTypeConsts.Price_Comparison;

    List<Activity> listActivity =
        json.map((e) => Activity.fromJson(e, activityType)).toList();
    return listActivity;
  }

  Future<List<Activity>> getListPhotoFromMission(
      MissionModel missionModel) async {
    return await getListActivityModelFromMission(
        missionModel, Strings.photoLines);
  }

  Future<List<Activity>> getListQuizzFromMission(
      MissionModel missionModel) async {
    return await getListActivityModelFromMission(
        missionModel, Strings.popsQuizz);
  }

  Future<List<Activity>> getListPriceComparisonFromMission(
      MissionModel missionModel) async {
    return await getListActivityModelFromMission(
        missionModel, Strings.price_comparison);
  }

  Future setQuizzLinesFromActivity(
      Activity activity) async {
    activity.listQuizzLinesModel = await getQuizzLinesFromActivity(activity);
  }

  Future<List<QuizzLinesModel>> getQuizzLinesFromActivity(
      Activity activity) async {
    return quizzLinesModelService.getQuizzLinesModelFromQuizz(activity.id);
  }

  Future<void> setMeasurementQuizzlinesModel(
    Activity activity,
    MeasurementModel measurementModel,
    User user,
  ) async {
    activity.measurementQuizzlinesModel = await measurementService
        .getMeasurementQuizzLinesFromMeasurementAndActivity(
            measurementModel, activity);
    activity.isChecked = (activity.measurementQuizzlinesModel != null);
  }

  Future<void> setMeasurementPhotoLinesModel(
    Activity activity,
    MeasurementModel measurementModel,
    User user,
  ) async {
    activity.measurementPhotoLinesModel = await measurementService
        .getMeasurementPhotoLinesFromMeasurementAndActivity(
            measurementModel, activity);
    activity.isChecked = (activity.measurementPhotoLinesModel != null);
  }
}
