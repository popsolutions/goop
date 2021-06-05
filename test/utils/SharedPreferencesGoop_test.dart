import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goop/utils/SharedPreferencesGoop.dart';

void main(){

  test('SharedPreferencesGoop', () async {
    SharedPreferencesGoop _sharedPreferencesGoop = SharedPreferencesGoop();
    _sharedPreferencesGoop.init(true);

    void testKey(String key, String expectValue){
      String curentValueKey = _sharedPreferencesGoop.getString(key);
      expect(curentValueKey, equals(expectValue));
    }

    void setKey(String key, String value){
      _sharedPreferencesGoop.setString(key, value);
      testKey(key, value);
    }

    void remove(String key){
      _sharedPreferencesGoop.remove(key);
      testKey(key, '');
    }

    void testLength(int length){
      expect(_sharedPreferencesGoop.listSharedLocalKeys.length, equals(length));
    }

    testLength(0);

    testKey('Keya', '');
    setKey('Keya', 'teste1');
    setKey('Keya', 'teste1');
    setKey('Keya', 'teste2');
    testLength(1);

    testKey('Keyb', '');
    setKey('Keyb', 'Keyb-teste1');
    setKey('Keyb', 'Keyb-teste1');
    setKey('Keyb', 'Keyb-teste2');
    testLength(2);

    testKey('Keya', 'teste2');
    testKey('Keyb', 'Keyb-teste2');

    remove('Keya');
    testLength(1);
    remove('Keyb');
    testLength(0);

    testKey('Keya', '');
    testKey('Keyb', '');

    testLength(0);
  });
}