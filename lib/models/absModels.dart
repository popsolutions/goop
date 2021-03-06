import 'package:goop/utils/utils.dart';

class AbsModels{
  Map<String, dynamic> currentJson = new Map<String, dynamic>();

  int jGetInt(String key, [int index]) => JsonGet.Int(currentJson, key, index);
  double jGetDouble(String key, [int index]) => JsonGet.Double(currentJson, key, index);
  DateTime jGetDate(String key, [int index]) => JsonGet.Datetime(currentJson, key, index);
  String jGetStr(String key, [int index]) => JsonGet.Str(currentJson, key, index);
  bool jGetBool(String key, [int index]) => JsonGet.Bool(currentJson, key, index);

}