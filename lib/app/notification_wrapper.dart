import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/models/local_notification.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/notification_utils.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationWrapper extends StatefulWidget {
  final Widget child;

  const NotificationWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _NotificationWrapperState createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  Future<void> initialiseFirebase() async {
    await Firebase.initializeApp();
  }

  late UserRepository userRepository;

  @override
  void initState() {
    print("initState for Notification wrapper called");
    super.initState();
    initialiseFirebase().then((value) {
      userRepository = RepositoryProvider.of<UserRepository>(context);
      initialiseFCM();
      registerFirebaseBackgroundNotification();
      registerFirebaseToken();
      // fetchNotificationTopics();
      listenRefreshToken();
      onForegroundMessageListen();
      onBackgroundMessageListened();
      onNotificationOpenedFromTerminated();
      onForegroundLocalNotification();
      // subscribeToNotificationTopic();
    });
  }

  // subscribeToNotificationTopic() {
  //   RepositoryProvider.of<NotificationRepository>(context)
  //       .subribeToDefaultNotications();
  // }

  // fetchNotificationTopics() {
  //   RepositoryProvider.of<NotificationRepository>(context)
  //       .subribeToDefaultNotications();
  // }

  registerFirebaseBackgroundNotification() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  registerFirebaseToken() async {
    final _token = await FirebaseMessaging.instance.getToken();
    print("Firebase");
    print(_token);
    print("Firebase");
    if (_token != null && userRepository.token.isNotEmpty) {
      await userRepository.updateNotificationToken();
    }
  }

  listenRefreshToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await userRepository.updateNotificationToken(refreshedToken: token);
    });
  }

  Future<void> initialiseFCM() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: NotificationUtils.notificationChannelKey);
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> onBackgroundMessageListened() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("heard notification");
      if (message.data.isNotEmpty) {
        final _tempNotificationData =
            NotificationUtils.convertToLocalPushNofication(message.data);
        NotificationUtils.handleNavigation(
            _tempNotificationData, NavigationService.context);
      }
    });
  }

  Future<void> onForegroundLocalNotification() async {
    // AwesomeNotifications().actionStream.listen((message) {
    //   if (message.payload?["data"] != null) {
    //     final _encodedData = message.payload!["data"]!;
    //     dynamic _decodedData;
    //     try {
    //       _decodedData = json.decode(_encodedData);
    //     } catch (e) {
    //       _decodedData = _encodedData;
    //     }
    //     if (_decodedData is Map) {
    //       final Map<String, dynamic> _data =
    //           Map<String, dynamic>.from(_decodedData);
    //       final _tempNotificationData =
    //           NotificationUtils.convertToLocalPushNofication(_data);
    //       NotificationUtils.handleNavigation(
    //         _tempNotificationData,
    //         NavigationService.context,
    //       );
    //     } else if (_decodedData is String) {
    //       final _doesFileExist = File(_decodedData).existsSync();
    //       // if (_doesFileExist) {
    //       //   OpenFilex.open(_decodedData);
    //       // }
    //     }
    //   }
    // });
  }

  Future<void> onNotificationOpenedFromTerminated() async {
    try {
      final _message = await FirebaseMessaging.instance.getInitialMessage();
      await Future.delayed(const Duration(seconds: 2), () {
        if (_message?.data.isNotEmpty ?? false) {
          final _tempNotificationData =
              NotificationUtils.convertToLocalPushNofication(_message!.data);
          NotificationUtils.handleNavigation(
              _tempNotificationData, NavigationService.context);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> onForegroundMessageListen() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print("heard message");
        print(message);
        print(message.data);
        final RemoteNotification? notification = message.notification;
        if (notification != null) {
          final Map<String, String> _notificationPayload = {
            "data": message.data.isNotEmpty ? json.encode(message.data) : ""
          };
          LocalPushNotification? _pushNotification;
          if (message.data.isNotEmpty) {
            _pushNotification =
                NotificationUtils.convertToLocalPushNofication(message.data);
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                title: notification.title,
                body: notification.body,
                displayOnForeground: true,
                payload: _notificationPayload,
                id: Random().nextInt(1000),
                channelKey: NotificationUtils.notificationChannelKey,
                autoDismissible: false,
                category: NotificationCategory.Event,
                wakeUpScreen: true,
                displayOnBackground: true,
                notificationLayout: NotificationLayout.BigText,
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
