import 'dart:convert';
import 'package:ismart/feature/authentication/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const _userKey = "AppUser";
  static const _firstTimeAppOpen = 'firstTimeAppOpen';
  static const _appToken = 'appToken';

  static Future setFirstTimeAppOpen(bool status) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setBool(_firstTimeAppOpen, status);
  }

  static Future<bool> getFirstTimeAppOpen() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getBool(_firstTimeAppOpen);
    if (res == null) {
      return true;
    }
    return res;
  }

  static Future setUser(User user) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setString(_userKey, json.encode(user.toJson()));
  }

  static Future<User?> getUser() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getString(_userKey);
    if (res == null) {
      return null;
    }
    return User.fromJson(json.decode(res));
  }

  static Future deleteUser() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_userKey);
  }

  static Future setToken(String jwtToken) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setString(_appToken, jwtToken);
  }

  static Future<String> getToken() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getString(_appToken);
    return res ?? "";
  }

  static Future deleteToken() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_appToken);
  }
}
