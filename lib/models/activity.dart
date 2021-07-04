import 'package:goop/models/absModels.dart';
import 'package:goop/models/measurementPriceComparisonLines.dart';
import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/utils/ClassConstants.dart';
import 'package:goop/utils/utils.dart';

import 'measurementPhotoLines.dart';

// ignore_for_file: non_constant_identifier_names
class Activity extends AbsModels {
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
  MeasurementPhotoLinesModel measurementPhotoLinesModel;
  MeasurementPriceComparisonLinesModel measurementPriceComparisonLinesModel;

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

  Activity.fromJson(Map<String, dynamic> map, String _activityType) {
    currentJson = map;

    String mission_idField = '';

    if (_activityType == ActivityTypeConsts.Photo) {
      mission_idField = 'mission_id';
    } else {
      mission_idField = 'missions_id';
    }

    if (!(map[mission_idField] is bool))
      mission_id = map[mission_idField][0];

    if (mission_id == 0)
      return;

    if (_activityType == ActivityTypeConsts.Price_Comparison) {
      if (!(map['product_id'] is bool)) {
        product_id = map['product_id'][0];
        name = map['product_id'][1];
      }
    } else {
      name = JsonGet.Str(map, 'name');
    }


    id = jGetInt('id');
    create_date = jGetStr('create_date');
    write_date = jGetStr('write_date');
    display_name = jGetStr('display_name');
    last_update = jGetStr('last_update');
    activityType = _activityType;
  }

  bool isPhoto() => activityType == ActivityTypeConsts.Photo;
  bool isQuizz() => activityType == ActivityTypeConsts.Quizz;
  bool isPriceComparison() => activityType == ActivityTypeConsts.Price_Comparison;

  int listQuizzLinesModelIndexSelected() {
    if (measurementQuizzlinesModel != null) {
      for (int i = 0; i < listQuizzLinesModel.length; ++i) {
        if (listQuizzLinesModel[i].alternative_id == measurementQuizzlinesModel.alternative_id) {
          return i;
        }
      }
    }

    return null;
  }
}
