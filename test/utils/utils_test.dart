import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goop/utils/utils.dart';

main() {
  test('ListInt_test', () {
    var model = {"id": 45, "name": "name sample", "quizz_line_ids": []};

    List<int> listInt = jsonGetListInt(model, 'quizz_line_ids');
    print(listInt);
    expect(listInt.length, 0);

    model = {
      "id": 45,
      "name": "name sample",
      "quizz_line_ids": [43, 44, 45, 46]
    };

    listInt = jsonGetListInt(model, 'quizz_line_ids');
    print(listInt);
    expect(listInt.length, 4);
    expect(listInt[0], 43);
    expect(listInt[1], 44);
    expect(listInt[2], 45);
    expect(listInt[3], 46);
  });

  test('timerTest', (){
    pDif(String value1, String value2){

      DateTime d1 = DateTime.parse(value1);
      DateTime d2 = DateTime.parse(value2);
      
      print(d1.toString() + ' - ' + d2.toString() + ' : ' + d2.difference(d1).inHours.toString() + ' - Horas');
      print(d1.toString() + ' - ' + d2.toString() + ' : ' + d2.difference(d1).inSeconds.toString() + ' - Segundos');
      print('');
    }

    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:00:00.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:00:01.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:01:00.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:01:01.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:59:00.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:59:01.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:59:59.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 13:00:00.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-22 13:00:00.000');
    pDif('2021-06-21 12:00:00.000', '2021-07-21 12:00:00.000');

  });

  test('timerTest2', (){
      pDif(String value1, String value2){

      DateTime d1 = DateTime.parse(value1);
      DateTime d2 = DateTime.parse(value2);

      setSeconds(int value1, int value2, int fraction){
        if (value1 >= fraction){
          value2 = (value1 / fraction).truncate();
          value1 = value1 - (value2 * fraction);
        }
      }

      int seconds = d2.difference(d1).inSeconds;
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

      print('Days: ' + days.toString());
      print('Hours: ' + hours.toString());
      print('Minutes: ' + minutes.toString());
      print('Seconds: ' + seconds.toString());
    }

    pDif('2021-06-21 12:00:00.000', '2021-07-22 15:27:03.000');

  });

  test('difDateStr', (){
    pDif(String value1, String value2){

      DateTime d1 = DateTime.parse(value1);
      DateTime d2 = DateTime.parse(value2);

      print(value1 + ' - ' + value2 + ': ' + difDateStr(d1, d2));

    }

    pDif('2021-06-21 12:00:00.000', '2021-06-21 15:27:59.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:27:03.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:00:03.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 12:00:00.000');
    pDif('2021-06-21 12:00:00.000', '2021-06-21 11:00:00.000');

  });


