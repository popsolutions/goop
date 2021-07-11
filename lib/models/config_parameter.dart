import 'package:goop/models/absModels.dart';
import 'package:goop/services/constants.dart';

class Config_ParameterModel extends AbsModels{
  String modelName = Strings.config_Parameter;

  int id;
  String key;
  String value;

  Config_ParameterModel(this.id, this.key, this.value);

  Config_ParameterModel.fromJson(Map<String, dynamic> json) {
    currentJson = json;

    id = jGetInt('id');
    key = jGetStr('key');
    value = jGetStr('value');
  }

}