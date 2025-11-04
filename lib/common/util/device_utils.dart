import 'dart:io';

// import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_marketing_names/device_marketing_names.dart';
// import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  static final DeviceUtils _deviceUtils = DeviceUtils._internal();

  factory DeviceUtils() {
    return _deviceUtils;
  }

  DeviceUtils._internal();

  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static const String _deviceId = "";

  static String _marketingName = "";

  static String _userAgent = "";

  static String _appVersion = "";

  // static Future<String> get getDeviceId async {
  //   if (_deviceId.isNotEmpty) {
  //     return _deviceId;
  //   }
  //   try {
  //     if (Platform.isAndroid) {
  //       _deviceId = await const AndroidId().getId() ?? "";
  //       return _deviceId;
  //     } else if (Platform.isIOS) {
  //       final res = await _deviceInfo.iosInfo;
  //       _deviceId = res.identifierForVendor ?? "";
  //       return _deviceId;
  //     }
  //     return _deviceId;
  //   } catch (e) {
  //     return _deviceId;
  //   }
  // }

  static Future<String> get getAppVersion async {
    if (_appVersion.isNotEmpty) {
      return _appVersion;
    } else {
      final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
      _appVersion = _packageInfo.version;
      return _appVersion;
    }
  }

  static Future<String> get getAppName async {
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo.appName;
  }

  static Future<String> get getPackageName async {
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo.packageName;
  }

  static Future<String> get getMarketingName async {
    if (_marketingName.isNotEmpty) {
      return _marketingName;
    }
    try {
      if (Platform.isAndroid) {
        final res = await _deviceInfo.androidInfo;
        final String _manufactureName = res.manufacturer;
        final String _model = res.model;
        final _deviceMarketNames = DeviceMarketingNames();
        final String _deviceName =
            _deviceMarketNames.getNamesFromModel(DeviceType.android, _model);
        _marketingName =
            _deviceName.isNotEmpty ? _deviceName : "$_manufactureName $_model";
        return _marketingName;
      } else if (Platform.isIOS) {
        final res = await _deviceInfo.iosInfo;
        final _deviceMarketNames = DeviceMarketingNames();
        String _iosName = _deviceMarketNames.getSingleNameFromModel(
            DeviceType.ios, res.utsname.machine);
        if (_iosName.isEmpty) {
          _iosName = "APPLE iPhone (iPhone)";
        }
        _marketingName = _iosName;
        return _iosName;
      }
      return _marketingName;
    } catch (e) {
      return _marketingName;
    }
  }

  static Future<String> get userAgent async {
    try {
      if (_userAgent.isNotEmpty) {
        return _userAgent;
      } else {
        // await FkUserAgent.init();
        // _userAgent = FkUserAgent.userAgent ?? "";
        _userAgent = "Dart/Flutter";
        print("Flutter User Agent : $_userAgent");
        return _userAgent;
      }
    } catch (e) {
      return "";
    }
  }

  static Future<Map<String, String>> get deviceInfoHeader async {
    final _uAgent = await userAgent;
    // final _deviceId = await getDeviceId;
    const _deviceId = "-1";
    final _marketName = await getMarketingName;
    final _aVersion = await getAppVersion;
    return {
      "user_agent": _uAgent,
      "device": _deviceId,
      "software_version": _aVersion,
      "model": _marketName,
    };
  }
}
