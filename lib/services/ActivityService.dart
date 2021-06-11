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

class ActivityService{
  Odoo _odoo = new Odoo();

  QuizzLinesModelService quizzLinesModelService = new QuizzLinesModelService();
  MeasurementService measurementService = new MeasurementService();

  Future<List<Activity>> getListActivityModelFromMission(MissionModel missionModel, String model, [String fieldMissionName = 'missions_id']) async {
    final response = await _odoo.searchRead(
      model,
      [
        [fieldMissionName, 'in', [missionModel.id]]
      ],
      [],
    );
    final List json = response.getRecords();

    String activityType = '';

    if (model == Strings.photoLines) activityType = ActivityTypeConsts.Photo;
    if (model == Strings.popsQuizz) activityType = ActivityTypeConsts.Quizz;
    if (model == Strings.price_comparison) activityType = ActivityTypeConsts.Price_Comparison;

    List<Activity> listActivity = json.map((e) => Activity.fromJson(e, activityType)).toList();
    return listActivity;
  }

  Future<List<QuizzLinesModel>> setQuizzLinesFromActivity(Activity activity) async {
    activity.listQuizzLinesModel = await getQuizzLinesFromActivity(activity);
  }

  Future<List<QuizzLinesModel>> getQuizzLinesFromActivity(Activity activity) async {
    return quizzLinesModelService.getQuizzLinesModelFromQuizz(activity.id);
  }

  Future<void> setMeasurementQuizzlinesModel(Activity activity, MeasurementModel measurementModel, User user) async {
    activity.measurementQuizzlinesModel = await measurementService.getMeasurementQuizzLinesFromMeasurementAndActivity(measurementModel, activity);
    activity.isChecked = (activity.measurementQuizzlinesModel != null);
  }
}