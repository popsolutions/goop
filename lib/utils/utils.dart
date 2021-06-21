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

String DateTimeToSql(DateTime date) {
  return (date == null) ? null : DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
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

String doubleToStringValue(double value) => value.toStringAsFixed(2).replaceAll('.', ',');

String difDateStr(DateTime dateFrom, DateTime dateTo){
  int seconds = dateTo.difference(dateFrom).inSeconds;
  int minutes = 0;
  int hours = 0;
  int days = 0;

  if (seconds >= (3600 * 24)){
    days = (seconds / (3600 * 24)).truncate();
    seconds = seconds - (days * (3600 * 24));
  }

  if (seconds >= 3600){
    hours = (seconds / 3600).truncate();
    seconds = seconds - (hours * 3600);
  }

  if (seconds >= 60){
    minutes = (seconds / 60).truncate();
    seconds = seconds - (minutes * 60);
  }

  String dif = '';

  add(int value, String sing, String plu){
    if (value != 0){
      if (dif != '')
        dif += ', ';

      dif += value.toString() + ' ' +  ((value == 1) ? sing : plu);
    }
  }

  add(days, 'dia', 'dias');
  add(hours, 'hora', 'horas');
  add(minutes, 'minuto', 'minutos');
  add(seconds, 'segundo', 'segundos');

  return dif;

}