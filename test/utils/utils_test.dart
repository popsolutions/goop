import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:goop/utils/utils.dart';

main(){

  test('ListInt_test', (){
    var model = {
      "id": 45,
      "name": "name sample",
      "quizz_line_ids": []
    };

    List<int> listInt = jsonGetListInt(model, 'quizz_line_ids');
    print(listInt);
    expect(listInt.length, 0);

    model = {
      "id": 45,
      "name": "name sample",
      "quizz_line_ids": [40, 50]
    };

    listInt = jsonGetListInt(model, 'quizz_line_ids');
    print(listInt);
    expect(listInt.length, 2);
    expect(listInt[0], 40);
    expect(listInt[1], 50);
  });

}