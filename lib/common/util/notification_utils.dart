import 'package:flutter/widgets.dart';
import 'package:ismart/common/models/local_notification.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationUtils {
  static const String notificationChannelKey = "ayoremit_notification_channel";
  static const String alert = "alert";
  static const String offers = "offers";
  static const String rooms = "rooms";

  static handleNavigation(
      LocalPushNotification localNotification, BuildContext context) async {
    if (localNotification.deeplink != null &&
        localNotification.deeplink!.isNotEmpty) {
      launchUrl(
        Uri.parse(localNotification.deeplink!),
      );
    }
  }

  static LocalPushNotification convertToLocalPushNofication(
      Map<String, dynamic> json) {
    return LocalPushNotification(
      id: json["id"] ?? "",
      type: json["model"] ?? "",
      deeplink: json["deeplink"],
    );
  }
}
