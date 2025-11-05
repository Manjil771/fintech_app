import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _secureStorageService =
      SecureStorageService._internal();

  factory SecureStorageService() {
    return _secureStorageService;
  }

  SecureStorageService._internal();

  static const String _walletPassword = "wallet_pass";

  static const String _walletPhoneNumber = "wallet_phone";
  static const String _loginStatus = "login_status";

  static FlutterSecureStorage get _storage {
    return const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
  }

  static setAppPassword(String password) async {
    try {
      final _ = await _storage.write(key: _walletPassword, value: password);
    } catch (e) {
      print("Error saving Password");
    }
  }

  static Future<String> get appPassword async {
    try {
      final String _pass = await _storage.read(key: _walletPassword) ?? "";
      return _pass;
    } catch (e) {
      return "";
    }
  }

  static setAppPhoneNumber(String phone) async {
    try {
      final _ = await _storage.write(key: _walletPhoneNumber, value: phone);
    } catch (e) {
      print("Error saving phonenumber");
    }
  }

  static Future<String> get appPhoneNumber async {
    try {
      final String _phone = await _storage.read(key: _walletPhoneNumber) ?? "";
      return _phone;
    } catch (e) {
      return "";
    }
  }

  static setLoginStatus(String loginStatus) async {
    try {
      final _ = await _storage.write(key: _loginStatus, value: loginStatus);
    } catch (e) {
      print("Error saving login status.");
    }
  }

  static Future<String> get loginStatus async {
    try {
      final String _status = await _storage.read(key: _loginStatus) ?? "";
      return _status;
    } catch (e) {
      return "";
    }
  }
}
