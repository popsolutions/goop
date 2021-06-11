import 'package:shared_preferences/shared_preferences.dart';

//The main purpose of the SharedPreferencesGoop class is "Simulate Mobile Shared Preferences(SharedPreferences) when running in test environment"
class SharedPreferencesGoop{

  bool _modeTest = false;
  List<SharedLocalKeys> listSharedLocalKeys = <SharedLocalKeys>[];
  SharedLocalKeys currentSharedLocalKeys;

  SharedPreferences prefs;

  void init(bool _modeTest) async{
    this._modeTest = _modeTest;

    if (!_modeTest)
      prefs = await SharedPreferences.getInstance();
  }

  bool findKey(String key){
    currentSharedLocalKeys = listSharedLocalKeys.firstWhere((element) => element.key == key, orElse: () => null);
    return !(currentSharedLocalKeys == null);
  }

  String getString(String key){
    String result = '';
    if (!_modeTest)
      result = prefs.getString(key);
    else{
      if (findKey(key))
        result = currentSharedLocalKeys.value;
    }

    return result;
  }

  remove(String key){
    if (!_modeTest)
      prefs.remove(key);
    else{
      if (findKey(key))
        listSharedLocalKeys.remove(currentSharedLocalKeys);
    }
  }

  setString(String key, String value){
    if (!_modeTest)
      prefs.setString(key, value);
    else{
      if (findKey(key))
        currentSharedLocalKeys.value = value;
      else
        listSharedLocalKeys.add(SharedLocalKeys(key, value));
    }
  }

}

class SharedLocalKeys{
  String key = '';
  String value = '';

  SharedLocalKeys(this.key, this.value);


}