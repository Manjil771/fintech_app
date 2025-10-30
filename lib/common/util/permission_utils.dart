import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<bool> get isCameraPermissionAvailable async {
    final _res = await Permission.camera.request();
    return _res.isGranted || _res.isLimited;
  }

  static Future<bool> get notificationPermissionAvailable async {
    final _res = await Permission.notification.request();
    return _res.isGranted || _res.isLimited;
  }
}
