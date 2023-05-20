import 'dart:async';
import 'dart:io';

import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/common/http/custom_exception.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/google_play_service_utils.dart';
import 'package:ismart/feature/authentication/model/user.dart';
import 'package:ismart/feature/authentication/resource/auth_api_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<DataResponse<User>> signInGoogle() async {
    try {
      if (Platform.isAndroid) {
        final _playServiceAvailability =
            await GooglePlayServiceUtils().checkGoogleService;
        if (!_playServiceAvailability) {
          return DataResponse.error("Google play service not available");
        }
      }
      final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile'
      ]);

      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final _res = await authApiProvider.googleSignIn(
            accessToken: googleAuth.accessToken!);
        final _result = Map<String, dynamic>.from(_res);
        _token = _result['data']['token']['accessToken'];
        await persistToken(_token);
        _user.value = User.fromJson(_result['data']['user']);
        SharedPref.setUser(_user.value!);
        await _getAndUpdateNotificationToken();
        _isLoggedIn.value = true;
        return DataResponse.success(_user.value!);
      } else {
        return DataResponse.error("Unable to Login!!");
      }
    } on CustomException catch (e) {
      return DataResponse.error(e.message!);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<User>> signInFacebook() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final _res = await authApiProvider.facebookSignIn(
            accessToken: accessToken.token);
        final _result = Map<String, dynamic>.from(_res);
        _token = _result['data']['token']['accessToken'];
        await persistToken(_token);
        _user.value = User.fromJson(_result['data']['user']);
        SharedPref.setUser(_user.value!);
        await _getAndUpdateNotificationToken();
        _isLoggedIn.value = true;
        return DataResponse.success(_user.value!);
      } else if (result.status == LoginStatus.failed) {
        return DataResponse.error(result.message ?? "Unable to login!!");
      } else {
        return DataResponse.error("Unable to login!!");
      }
    } on CustomException catch (e) {
      return DataResponse.error(e.message!);
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

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
