import 'dart:io';
import 'package:ismart/feature/update/model/appVersion.dart';
import 'package:ismart/feature/update/model/app_update.dart';

class UpdateUtils {
  static bool isUpdateAvailable(
      {required String currentVersion, required AppUpdate appUpdate}) {
    final _currentAppVersion = AppVersion.fromString(currentVersion);
    final _latestAppVersion = AppVersion.fromString(
      Platform.isAndroid
          ? appUpdate.android.minimumVersionSupport
          : appUpdate.ios.minimumVersionSupport,
    );

    bool _update = false;

    if (_latestAppVersion.major > _currentAppVersion.major) {
      _update = true;
    } else if (_latestAppVersion.major == _currentAppVersion.major) {
      if (_latestAppVersion.minor > _currentAppVersion.minor) {
        _update = true;
      } else if (_latestAppVersion.minor == _currentAppVersion.minor) {
        if (_latestAppVersion.patch > _currentAppVersion.patch) {
          _update = true;
        }
      }
    }

    return _update;
  }

  static bool isForceUpdateAvailable(
      {required String currentVersion, required AppUpdate appUpdate}) {
    final _currentAppVersion = AppVersion.fromString(currentVersion);
    final _minVersionSupport = AppVersion.fromString(
      Platform.isAndroid
          ? appUpdate.android.minimumVersionSupport
          : appUpdate.ios.minimumVersionSupport,
    );

    bool _update = false;

    if (_minVersionSupport.major > _currentAppVersion.major) {
      _update = true;
    } else if (_minVersionSupport.major == _currentAppVersion.major) {
      if (_minVersionSupport.minor > _currentAppVersion.minor) {
        _update = true;
      } else if (_minVersionSupport.minor == _currentAppVersion.minor) {
        if (_minVersionSupport.patch > _currentAppVersion.patch) {
          _update = true;
        }
      }
    }

    return _update;
  }
}
