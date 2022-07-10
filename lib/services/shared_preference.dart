import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static String checkPermissionKey = "checkPermission";
  static String userIdKey = "userId";
  static String passwordKey = "password";
  static String keepMeLogInKey = "keepMeLogIn";
  static String lastReadAlarmIdKey = "lastReadAlarmId";

  Future<bool> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, userId);
  }

  Future<bool> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(passwordKey, password);
  }

  Future<bool> saveKeepMeLogIn(bool isKeep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(keepMeLogInKey, isKeep);
  }

  Future<bool> saveCheckedPermission(bool checked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(checkPermissionKey, checked);
  }

  Future<bool> saveLastReadAlarmId(String lastReadAlarmId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(lastReadAlarmIdKey, lastReadAlarmId);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey) ?? '';
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(passwordKey) ?? "";
  }

  Future<bool> getKeepMeLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keepMeLogInKey) ?? false;
  }

  Future<bool> getCheckedPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(checkPermissionKey) ?? false;
  }

  Future<String> getLastReadAlarmId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastReadAlarmIdKey) ?? "-1";
  }

  Future clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userIdKey);
    prefs.remove(passwordKey);
    prefs.remove(keepMeLogInKey);
  }

  Future clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userIdKey);
    prefs.remove(passwordKey);
    prefs.remove(keepMeLogInKey);
    prefs.remove(checkPermissionKey);
  }
}
