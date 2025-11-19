import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:ismart/common/models/local_notification.dart';
import 'package:ismart/common/util/url_launcher.dart';

class NotificationUtils {
  static const String notificationChannelKey = "ismart_notification_channel";
  static const String alert = "alert";
  static const String offers = "offers";
  static const String rooms = "rooms";

  static handleNavigation(
      LocalPushNotification localNotification, BuildContext context) async {
    if (localNotification.deeplink != null &&
        localNotification.deeplink!.isNotEmpty) {
      UrlLauncher.launchUrlLink(
        context: context,
        url: localNotification.deeplink!,
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

  static generateDownloadingNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1001,
        channelKey: notificationChannelKey,
        title: "Downloading file...",
        displayOnForeground: true,
        autoDismissible: false,
        category: NotificationCategory.Event,
        wakeUpScreen: true,
        displayOnBackground: true,
      ),
    );
    // FlutterAppBadger.removeBadge();
  }

  static generateDownloadCompletedNotification(String filePath) async {
    final bool _isCreated = await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1001,
        channelKey: notificationChannelKey,
        title: "Download Completed !",
        payload: {"data": filePath},
        displayOnForeground: true,
        autoDismissible: false,
        category: NotificationCategory.Event,
        wakeUpScreen: true,
        displayOnBackground: true,
      ),
    );
    print("Notification has been created : $_isCreated");
    // FlutterAppBadger.removeBadge();
  }

  static generateDownloadFailedNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1001,
        channelKey: notificationChannelKey,
        title: "Download failed !",
        displayOnForeground: true,
        autoDismissible: false,
        category: NotificationCategory.Event,
        wakeUpScreen: true,
        displayOnBackground: true,
      ),
    );
    // FlutterAppBadger.removeBadge();
  }

  static generateDownloadCancelledNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1001,
        channelKey: notificationChannelKey,
        title: "Download cancelled !",
        displayOnForeground: true,
        autoDismissible: false,
        category: NotificationCategory.Event,
        wakeUpScreen: true,
        displayOnBackground: true,
      ),
    );
    // FlutterAppBadger.removeBadge();
  }
}
