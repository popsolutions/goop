import 'package:goop/models/absModels.dart';

class QuizzLinesModel extends AbsModels {
  int id;
  int alternative_id;
  String alternative_name;
  bool correct;

  QuizzLinesModel({
    this.id,
    this.alternative_id,
    this.alternative_name,
    this.correct
  });

  QuizzLinesModel.fromJson(Map<String, dynamic> json) {
    currentJson = json;

    id = jGetInt("id");
    alternative_id = jGetInt("alternative_id", 0);
    alternative_name = jGetStr("alternative_id", 1);
    correct = jGetBool("correct");
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "alternative_id": alternative_id,
    "alternative_name": alternative_name,
    "correct": correct
  };
}
