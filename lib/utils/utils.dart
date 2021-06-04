

import 'dart:convert';

dynamic valueOrNull(dynamic value) {
  return value is! bool ? value : null;
}

// ignore: non_constant_identifier_names
String JSONToStringWrapQuotClear(dynamic JSON){
  String s = json.encode(JSON);
  return s.replaceAll(',', ',\n').replaceAll('"', '').replaceAll(':', ': ');
}
