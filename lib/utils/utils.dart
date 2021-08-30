import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:image/image.dart' as Im;
// import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

dynamic valueOrNull(dynamic value) {
  return value is! bool ? value : null;
}

// ignore: non_constant_identifier_names
String JSONToStringWrapQuotClear(dynamic JSON) {
  String s = json.encode(JSON);
  return s.replaceAll(',', ',\n').replaceAll('"', '').replaceAll(':', ': ');
}

class JsonGet {
  static bool jsonKeyIsNull(dynamic value) => ((value == null) || (value is bool));

  static dynamic jGet(Map<String, dynamic> json, String key, [int index, dynamic valueIfNull]){
    if (jsonKeyIsNull(json[key]))
      return valueIfNull;

    if (index == null)
      return json[key];
    else
      return json[key][index];
  }

  static String Str(Map<String, dynamic> json, String key, [int index]) => jGet(json, key, index, '');

  static int Int(Map<String, dynamic> json, String key, [int index]) => jGet(json, key, index);

  static double Double(Map<String, dynamic> json, String key, [int index]) => convertDynamicToDouble(jGet(json, key, index));

  static DateTime Datetime(Map<String, dynamic> json, String key, [int index]) {
    if (json[key] is bool) return null;

    return DateTime.parse(jGet(json, key, index));
  }

  static bool Bool(Map<String, dynamic> json, String key, [int index]) {
    if (json[key] == null) return false;

    return json[key];
  }

  static List<int> ListInt(Map<String, dynamic> json, String key) {
    //json in format [1, 2, 4, 100]

    List<dynamic> listDynamic = json[key];
    List<int> listInt = <int>[];

    if (!listDynamic.isEmpty)
      listDynamic.forEach((element) {
        listInt.add(element);
      });

    return listInt;
  }
}

String convertDateToStringFormat(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

String convertDateToStringOdoo(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String DateToSql(DateTime date) {
  return (date == null) ? null : DateFormat('yyyy-MM-dd').format(date);
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

DateTime convertStringToDateTime(String dateTime) {
  //dateTime in Format Example => '2021-12-01 23:59:59'
  return DateTime.parse(dateTime);
}

void ToDevelop(String s) {
  printL(':: To Develop: $s');
}

String doubleToStringValue(double value) =>
    value.toStringAsFixed(2).replaceAll('.', ',');

double formatCurrencyDouble(double value) {
  value = (value == null) ? 0 : value;
  var vlDecimal = value.toStringAsFixed(2);
  return double.parse(vlDecimal);
}

double CurrencyStringtoDouble(String value) {
  if ((value??'') == '')
    value = '0';

  String vlCurrency = value
      .replaceAll("R\$", '')
      .replaceAll(' ', '')
      .replaceAll('.', '')
      .replaceAll(',', '.');

  return formatCurrencyDouble(double.parse(vlCurrency.trim()));
}

double convertDynamicToDouble(dynamic value) {
  if (value == null)
    return null;

  String valueString = value.toString();
  valueString = valueString
      .replaceAll("R\$", '')
      .replaceAll(' ', '')
      .replaceAll(',', '.');

  return double.parse(valueString);
}

double convertStringToDouble(String value) {
  return convertDynamicToDouble(value);
}

int convertStringToInt(String value) {
  return int.parse(value);
}

int difDateSeconds(DateTime dateFrom, DateTime dateTo) {
  return dateTo.difference(dateFrom).inSeconds;
}

String convertSecondsToHHMMSS(int seconds){
  int minutes = 0;
  int hours = 0;
  int days = 0;

  if (seconds >= (3600 * 24)) {
    days = (seconds / (3600 * 24)).truncate();
    seconds = seconds - (days * (3600 * 24));
  }

  if (seconds >= 3600) {
    hours = (seconds / 3600).truncate();
    seconds = seconds - (hours * 3600);
  }

  if (seconds >= 60) {
    minutes = (seconds / 60).truncate();
    seconds = seconds - (minutes * 60);
  }

  String dif = '';

  add(int value, String sing, String plu) {
    if (value != 0) {
      if (dif != '') dif += ', ';

      dif += value.toString() + ' ' + ((value == 1) ? sing : plu);
    }
  }

  add(days, 'dia', 'dias');
  add(hours, 'hora', 'horas');
  add(minutes, 'minuto', 'minutos');
  add(seconds, 'segundo', 'segundos');

  return dif;
}

Future<void> delayedSeconds(int _seconds) async =>
    await Future.delayed(Duration(seconds: _seconds));

Future<void> delayedMileconds(int _mileSeconds) async =>
    await Future.delayed(Duration(milliseconds: _mileSeconds));

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

printL(Object object) => print(object);
// printL(Object object) => null;
printL2(Object object) => print(object);

Log(String source, String log){
  printL('**Log: $source - $log');
}

class ImageGoop{
  String imageBase64;

  ImageGoop([this.imageBase64 = null]);

  Uint8List uint8List() => Base64Codec().decode(imageBase64);

  bool isNullOrEmpty() => (imageBase64 ?? '') == '';
}

void throwIf(bool b, String msg) {
  if (b)
    throw msg;
}

void throwIfNull(dynamic value, String msg) {
  if (value == null)
    throw msg;
}