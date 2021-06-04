

import 'dart:convert';

dynamic valueOrNull(dynamic value) {
  return value is! bool ? value : null;
}

String JSONToStringWrapQuotClear(dynamic JSON){
  String s = json.encode(JSON);
  return s.replaceAll(',', ',\n').replaceAll('"', '').replaceAll(':', ': ');
}
