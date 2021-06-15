import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/utils/ClassConstants.dart';
import 'package:goop/utils/utils.dart';

// ignore_for_file: non_constant_identifier_names
class Activity {
  int id;
  int product_id;
  String name;
  int mission_id;
  String create_date;
  String write_date;
  String display_name;
  String last_update; // original name "__last_update"
  String activityType; //ActivityTypeConsts
  bool isChecked = false;

  List<QuizzLinesModel> listQuizzLinesModel = <QuizzLinesModel>[];
  MeasurementQuizzlinesModel measurementQuizzlinesModel;

  Activity(
      {this.id,
      this.product_id,
      this.name,
      this.mission_id,
      this.create_date,
      this.write_date,
      this.display_name,
      this.last_update,
      this.activityType});

  factory Activity.fromJson(Map<String, dynamic> map, String activityType) {
    String mission_idField = '';
    String name = '';
    int product_id = 0;
    int mission_id = 0;

    if (activityType == ActivityTypeConsts.Photo) {
      mission_idField = 'mission_id';
    } else {
      mission_idField = 'missions_id';
    }

    if (activityType == ActivityTypeConsts.Price_Comparison) {
      if (!(map['product_id'] is bool)) {
        product_id = map['product_id'][0];
        name = map['product_id'][1];
      }
    } else {
      name = map['name'];
    }

    if (!(map[mission_idField] is bool)) mission_id = map[mission_idField][0];

    if (mission_id == 0) return null;

    return Activity(
        id: valueOrNull(map['id']),
        product_id: product_id,
        name: valueOrNull(name),
        mission_id: mission_id,
        create_date: valueOrNull(map['create_date']),
        write_date: valueOrNull(map['write_date']),
        display_name: valueOrNull(map['display_name']),
        last_update: valueOrNull(map['last_update']),
        activityType: activityType);
  }

  bool isPhoto() => activityType == ActivityTypeConsts.Photo;
  bool isQuizz() => activityType == ActivityTypeConsts.Quizz;
  bool isPriceComparison() =>
      activityType == ActivityTypeConsts.Price_Comparison;
}
