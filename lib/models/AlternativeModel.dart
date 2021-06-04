import 'dart:convert';


class AlternativeModel {
  int id;
  String name;

  AlternativeModel({
    this.id,
    this.name,
  });


  factory AlternativeModel.fromJson(Map<String, dynamic> json) => AlternativeModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
