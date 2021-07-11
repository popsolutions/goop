import 'package:goop/models/absModels.dart';
import 'package:goop/services/constants.dart';

class MobileVariablesModel extends AbsModels {
  String modelName = Strings.mobileVariables;

  int id;
  String x_variable_name;
  String x_variable_value;
  String x_variable_description;

  MobileVariablesModel({this.id, this.x_variable_name, this.x_variable_value, this.x_variable_description});

  MobileVariablesModel.fromJson(Map<String, dynamic> json) {
    currentJson = json;

    id = jGetInt('id');
    x_variable_name = jGetStr('x_variable_name');
    x_variable_value = jGetStr('x_variable_value');
    x_variable_description = jGetStr('x_variable_description');
  }

  Map<String, dynamic> toJson() {
    currentJson['id'] = this.id;
    currentJson['x_variable_name'] = this.x_variable_name;
    currentJson['x_variable_value'] = this.x_variable_value;
    currentJson['x_variable_description'] = this.x_variable_description;

    return currentJson;
  }
}
