import 'package:shared_preferences/shared_preferences.dart';

class PreferenceConnector {
  static const LOGGED_BEFORE = 'logged_before';
  static const DEVICE_ID = 'device_id';
  static const LOGIN_DATE_TIME = 'login_date_time';
  static const THEME_SELECTED = 'ENVIRONMENT';

  _getSharedPreference() async {
    return await SharedPreferences.getInstance();
  }

  Future<String> getString(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    return prefs.getString(key) ?? '';
  }

  Future<int> getInt(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    return prefs.getInt(key) ?? -1;
  }

  Future<bool> getBool(String key) async {
    SharedPreferences prefs = await _getSharedPreference();
    return prefs.getBool(key) ?? false;
  }

  void setString(String key, String value) async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.setString(key, value);
  }

  void setInt(String key, int value) async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.setInt(key, value);
  }

  void setBool(String key, bool value) async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.setBool(key, value);
  }

  void clearAll() async {
    SharedPreferences prefs = await _getSharedPreference();
    prefs.clear();
  }
}
