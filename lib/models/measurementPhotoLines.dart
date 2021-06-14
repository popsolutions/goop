//Class Measurement_quizzlinesModel is a Response to quizz into Measurement
import 'package:goop/services/constants.dart';

class MeasurementPhotoLinesModel {
  String modelName = Strings.measurement_photoLine;

  int id;
  int measurement_id;
  String name;
  String photo;
  int photo_id; //pops.photo.lines-id
  int create_uid;
  int write_uid;

  MeasurementPhotoLinesModel({this.id, this.measurement_id, this.name, this.photo, this.photo_id, this.create_uid, this.write_uid});

  MeasurementPhotoLinesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    measurement_id = json['measurement_id'][0];
    name = json['name'];
    photo = json['photo'];
    photo_id = json['photo_id'][0];
    create_uid = json['create_uid'][0];
    write_uid = json['write_uid'][0];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['measurement_id'] = this.measurement_id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['photo_id'] = this.photo_id;
    data['create_uid'] = this.create_uid;
    data['write_uid'] = this.write_uid;

    return data;
  }

}