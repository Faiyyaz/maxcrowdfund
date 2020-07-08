import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<dynamic> get(String key) async {
    var value;
    final _sharedPreference = await SharedPreferences.getInstance();
    value = _sharedPreference.get(key);
    return value;
  }

  Future<dynamic> set(String key, dynamic value) async {
    final _sharedPreference = await SharedPreferences.getInstance();
    if (value is bool) {
      _sharedPreference.setBool(key, value);
    } else if (value is int) {
      _sharedPreference.setInt(key, value);
    } else if (value is String) {
      _sharedPreference.setString(key, value);
    } else {
      _sharedPreference.setDouble(key, value);
    }
  }

  Future clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
