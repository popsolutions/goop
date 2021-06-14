import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

dynamic valueOrNull(dynamic value) {
  return value is! bool ? value : null;
}

// ignore: non_constant_identifier_names
String JSONToStringWrapQuotClear(dynamic JSON) {
  String s = json.encode(JSON);
  return s.replaceAll(',', ',\n').replaceAll('"', '').replaceAll(':', ': ');
}

String jsonGetStr(Map<String, dynamic> json, String key) {
  if (json[key] is bool) return null;

  return json[key];
}

List<int> jsonGetListInt(Map<String, dynamic> json, String key) {

  List<dynamic> listDynamic = json[key];
  List<int> listInt = <int>[];

  if (!listDynamic.isEmpty)
    listDynamic.forEach((element) {listInt.add(element);});

  return listInt;
}

String convertDateToStringFormat(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

String DateToSql(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String convertTimeToStringFormat(DateTime date) {
//Return examples => "00:01", "09:01", "19:59", "23:59"
  return DateFormat('H:mm').format(date);
}

String convertDateTimeToStringFormat(DateTime date) {
  return '${convertDateToStringFormat(date)} ${convertTimeToStringFormat(date)}';
}

void ToDevelop(String s){
  print(':: To Develop: $s');
}