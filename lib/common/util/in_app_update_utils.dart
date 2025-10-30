import 'dart:io';

import 'package:in_app_update/in_app_update.dart';
import 'package:new_version_plus/new_version_plus.dart';

class InAppUpdateUtils {
  static Future<bool> get isUpdateAvailable async {
    if (Platform.isAndroid) {
      try {
        final _appUpdateResult = await InAppUpdate.checkForUpdate();
        return _appUpdateResult.flexibleUpdateAllowed ||
            _appUpdateResult.immediateUpdateAllowed;
      } catch (e) {
        return false;
      }
    } else {
      final newVersion = NewVersionPlus();
      final res = await newVersion.getVersionStatus();
      if (res != null) {
        return res.canUpdate;
      }
      return false;
    }
  }

  static Future<void> startFlexibleUpdate() async {
    final _appUpdateResult = await InAppUpdate.checkForUpdate();
    if (_appUpdateResult.flexibleUpdateAllowed) {
      final _res = await InAppUpdate.startFlexibleUpdate();
      if (_res == AppUpdateResult.success) {
        final _ = await InAppUpdate.completeFlexibleUpdate();
      }
    }
  }
}
