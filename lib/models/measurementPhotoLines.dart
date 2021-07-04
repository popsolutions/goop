//Class Measurement_quizzlinesModel is a Response to quizz into Measurement
import 'package:goop/models/absModels.dart';
import 'package:goop/services/constants.dart';
import 'package:goop/utils/utils.dart';

class MeasurementPhotoLinesModel extends AbsModels{
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
    currentJson = json;

    id = jGetInt('id');
    measurement_id = jGetInt('measurement_id', 0);
    name = jGetStr('name');
    photo_id = jGetInt('photo_id', 0);
    create_uid = jGetInt('create_uid', 0);
    write_uid = jGetInt('write_uid', 0);
    photo = JsonGet.Str(json, 'photo');
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