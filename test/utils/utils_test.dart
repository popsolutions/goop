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
}
