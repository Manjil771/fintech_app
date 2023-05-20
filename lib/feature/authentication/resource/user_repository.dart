import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/feature/authentication/model/user.dart';
import 'package:ismart/feature/authentication/resource/auth_api_provider.dart';

class UserRepository {
  ApiProvider apiProvider;
  late AuthApiProvider authApiProvider;
  Env env;

  String _token = '';
  final ValueNotifier<User?> _user = ValueNotifier(null);

  UserRepository({
    required this.env,
    required this.apiProvider,
  }) {
    authApiProvider = AuthApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
    );

    print(authApiProvider);
  }

  Future initialState() async {
    _token = await fetchToken();
    _isLoggedIn.value = _token.isNotEmpty;
    _user.value = await SharedPref.getUser();
  }

  Future<bool> logout() async {
    try {
      _token = '';
      _isLoggedIn.value = false;
      _user.value = null;
      await SharedPref.deleteToken();
      await SharedPref.deleteUser();
      return true;
    } on Exception catch (_) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<bool> persistToken(String token) async {
    try {
      await SharedPref.setToken(token);
      _isLoggedIn.value = true;
      return true;
    } on Exception catch (_) {
      print('custom exception is been obtained');
    }
    return false;
  }

  Future<String> fetchToken() async {
    try {
      final token = await SharedPref.getToken();
      if (token.isNotEmpty) {
        _token = token;
      }

      print("Token------------------------------------------");
      print(token);
    } on Exception catch (_) {
      print('custom exception is been obtained');
    }
    return token;
  }

  ValueNotifier<User?> get user => _user;

  String get token => _token;

  final ValueNotifier<bool> _isLoggedIn = ValueNotifier(false);

  ValueNotifier<bool> get isLoggedIn => _isLoggedIn;

  Future<void> _getAndUpdateNotificationToken() async {
    final String? firebabseToken = await FirebaseMessaging.instance.getToken();
    if (firebabseToken != null) {
      updateNotificationToken(notificationToken: firebabseToken);
    }
  }

  Future<DataResponse<bool>> updateNotificationToken(
      {required String notificationToken}) async {
    try {
      await authApiProvider.sendNotificationToken(
        notificationToken: notificationToken,
        token: _token,
      );
      return DataResponse.success(true);
    } on CustomException catch (e) {
      return DataResponse.error(
          e.message ?? "Unable to update notification token");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<User>> fetchProfile() async {
    try {
      final _res = await authApiProvider.fetchProfile(token: token);
      final _result = Map<String, dynamic>.from(_res);
      _user.value = User.fromJson(_result['data']);
      SharedPref.setUser(_user.value!);
      return DataResponse.success(_user.value!);
    } on CustomException catch (e) {
      return DataResponse.error(e.message!);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
