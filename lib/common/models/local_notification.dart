import 'package:ismart/common/util/notification_utils.dart';

class LocalPushNotification {
  String type;
  String id;
  String? deeplink;

  LocalPushNotification({
    required this.id,
    required this.type,
    this.deeplink,
  });

  NotificationType get notificationType {
    if (type.toLowerCase().contains(NotificationUtils.alert.toLowerCase())) {
      return NotificationType.Alert;
    } else {
      return NotificationType.Offers;
    }
  }
}

enum NotificationType { Alert, Offers }
