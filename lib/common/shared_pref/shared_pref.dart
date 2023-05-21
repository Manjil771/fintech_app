import 'dart:convert';
import 'package:ismart/feature/authentication/model/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const _userKey = "AppUser";
  static const _firstTimeAppOpen = 'firstTimeAppOpen';
  static const _appAccessToken = 'appToken';
  static const _refresh_token = 'refresh_token';

  static const _rememberNumber = "rememberNumber";

  static const _biometricLogin = "biometricLogin";

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
    User? _localUser;
    try {
      _localUser = User.fromJson(json.decode(res));
    } catch (e) {
      return null;
    }
    return _localUser;
  }

  static Future deleteUser() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_userKey);
  }

  static Future setAccessToken(String jwtToken) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setString(_appAccessToken, jwtToken);
  }

  static Future getRememberNumber() async {
    final _instance = await SharedPreferences.getInstance();
    final _res = _instance.getString(_rememberNumber);
    return _res ?? "";
  }

  static Future setRememberUserNumber(String phoneNumber) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setString(_rememberNumber, phoneNumber);
  }

  static Future removeRememberMeNumber() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_rememberNumber);
  }

  static Future<String> getAccessToken() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getString(_appAccessToken);
    return res ?? "";
  }

  static Future setRefreshToken(String refreshToken) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setString(_refresh_token, refreshToken);
  }

  static Future<String> getRefreshToken() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getString(_refresh_token);
    return res ?? "";
  }

  static Future deleteAccessToken() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_appAccessToken);
    await _instance.remove(_refresh_token);
  }

  static Future setBiometricLogin(bool status) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setBool(_biometricLogin, status);
  }

  static Future<bool?> getBiometricLogin() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getBool(_biometricLogin);
    return res;
  }

  static Future removeBiometricLogin() async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.remove(_biometricLogin);
  }
}
