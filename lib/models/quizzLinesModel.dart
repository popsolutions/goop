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

  factory QuizzLinesModel.fromJson(Map<String, dynamic> json) =>
      QuizzLinesModel(
        id: json["id"],
        alternative_id: json["alternative_id"][0],
        alternative_name: json["alternative_id"][1],
        correct: json["correct"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "alternative_id": alternative_id,
    "alternative_name": alternative_name,
    "correct": correct
  };
}
