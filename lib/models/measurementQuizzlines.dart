//Class Measurement_quizzlinesModel is a Response to quizz into Measurement
import 'package:goop/models/absModels.dart';
import 'package:goop/services/constants.dart';


class MeasurementQuizzlinesModel extends AbsModels {
  String modelName = Strings.measurement_quizzLines;

  int id;
  String name;
  int quizz_id;
  String quizz_name;
  int alternative_id;
  String alternative_name;
  int measurement_id;
  int create_uid;
  DateTime create_date;
  int write_uid;
  String display_name;

  MeasurementQuizzlinesModel(
      {this.id,
      this.name,
      this.quizz_id,
      this.alternative_id,
      this.measurement_id,
      this.create_uid,
      this.create_date,
      this.write_uid,
      this.display_name});

  MeasurementQuizzlinesModel.fromJson(Map<String, dynamic> json) {
    currentJson = json;

    id = jGetInt('id');
    name = jGetStr('name');
    quizz_id = jGetInt('quizz_id', 0);
    quizz_name = jGetStr('quizz_id', 1);
    alternative_id = jGetInt('alternative_id', 0);
    alternative_name = jGetStr('alternative_id', 1);
    measurement_id = jGetInt('measurement_id', 0);
    create_uid = jGetInt('create_uid', 0);
    create_date = jGetDate('create_date');
    write_uid = jGetInt('write_uid', 0);
    display_name = jGetStr('display_name');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quizz_id'] = this.quizz_id;
    data['alternative_id'] = this.alternative_id;
    data['measurement_id'] = this.measurement_id;
    data['create_uid'] = this.create_uid;
    data['create_date'] = this.create_date;
    data['write_uid'] = this.write_uid;
    data['display_name'] = this.display_name;
    return data;
  }
}
