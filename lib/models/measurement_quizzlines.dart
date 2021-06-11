//Class Measurement_quizzlinesModel is a Response to quizz into Measurement
class Measurement_quizzlinesModel {
  int id;
  String name;
  int quizz_id;
  int alternative_id;
  int measurement_id;
  int create_uid;
  DateTime create_date;
  int write_uid;
  String display_name;

  Measurement_quizzlinesModel(
      {this.id,
      this.name,
      this.quizz_id,
      this.alternative_id,
      this.measurement_id,
      this.create_uid,
      this.create_date,
      this.write_uid,
      this.display_name});

  Measurement_quizzlinesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quizz_id = json['quizz_id'][0];
    alternative_id = json['alternative_id'][0];
    measurement_id = json['measurement_id'][0];
    create_uid = json['create_uid'][0];
    create_date = DateTime.parse(json['create_date']);
    write_uid = json['write_uid'][0];
    display_name = json['display_name'];
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
