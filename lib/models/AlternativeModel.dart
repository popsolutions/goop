import 'package:goop/models/absModels.dart';

class AlternativeModel extends AbsModels {
  int id;
  String name;

  AlternativeModel({
    this.id,
    this.name,
  });

  AlternativeModel.fromJson(Map<String, dynamic> json) {
    currentJson = json;
    id = jGetInt("id");
    name= jGetStr("name");
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
