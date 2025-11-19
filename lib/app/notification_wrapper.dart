// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/models/local_notification.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/notification_utils.dart';
// import 'package:ismart/common/util/permission_utils.dart';
// import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// import 'package:ismart/feature/authentication/resource/user_repository.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

// class NotificationWrapper extends StatefulWidget {
//   final Widget child;

//   const NotificationWrapper({Key? key, required this.child}) : super(key: key);

//   @override
//   _NotificationWrapperState createState() => _NotificationWrapperState();
// }

// class _NotificationWrapperState extends State<NotificationWrapper> {
//   Future<void> initialiseFirebase() async {
//     if (!kIsWeb) {
//       final _raised = await Firebase.initializeApp(
//         options: const FirebaseOptions(
//           apiKey: 'AIzaSyDtxGZ63t5k5Fq3Or-3NESUSkYDsBL885I',
//           appId: '1:484503989430:android:1bc2ea328370b4284aca17',
//           messagingSenderId: '484503989430',
//           projectId: 'ismart-7d185',
//           storageBucket: 'myapp-b9yt18.appspot.com',
//         ),
//       );
//     }
//   }

//   late UserRepository userRepository;

//   @override
//   void initState() {
//     // print("initState for Notification wrapper called");
//     super.initState();
//     if (!kIsWeb) {
//       initialiseFirebase().then((value) {
//         userRepository = RepositoryProvider.of<UserRepository>(context);
//         initialiseFCM();
//         registerFirebaseBackgroundNotification();
//         registerFirebaseToken();

//         AwesomeNotifications().initialize(
//             // set the icon to null if you want to use the default app icon
//             null,
//             [
//               NotificationChannel(
//                 channelGroupKey: 'notification_group',
//                 channelKey: NotificationUtils.notificationChannelKey,
//                 channelName: 'Default Channel',
//                 channelDescription: 'Default Notifications',
//                 defaultColor: const Color(0xFF9D50DD),
//                 ledColor: Colors.white,
//               )
//             ],
//             // Channel groups are only visual and are not required
//             channelGroups: [
//               NotificationChannelGroup(
//                 channelGroupKey: 'notification_group',
//                 channelGroupName: 'Notification Group',
//               )
//             ],
//             debug: true);

//         AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//           if (!isAllowed) {
//             // This is just a basic example. For real apps, you must show some
//             // friendly dialog box before call the request method.
//             // This is very important to not harm the user experience
//             AwesomeNotifications().requestPermissionToSendNotifications();
//           }
//         });

//         listenRefreshToken();
//         onForegroundMessageListen();
//         onBackgroundMessageListened();
//         onNotificationOpenedFromTerminated();
//         onForegroundLocalNotification();
//       });
//     }
//   }

//   // subscribeToNotificationTopic() {
//   //   RepositoryProvider.of<NotificationRepository>(context)
//   //       .subribeToDefaultNotications();
//   // }

//   // fetchNotificationTopics() {
//   //   RepositoryProvider.of<NotificationRepository>(context)
//   //       .subribeToDefaultNotications();
//   // }

//   registerFirebaseBackgroundNotification() {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }

//   registerFirebaseToken() async {
//     final _token = await FirebaseMessaging.instance.getToken();
//     print("FirebaseTokenInitiated $_token");
//     print(_token);
//     print("FirebaseTokenInitiated $_token");
//     if (_token != null && userRepository.token.isNotEmpty) {
//       await userRepository.updateNotificationToken();
//     }
//   }

//   listenRefreshToken() async {
//     FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
//       await userRepository.updateNotificationToken(refreshedToken: token);
//     });
//   }

//   Future<void> initialiseFCM() async {
//     AwesomeNotifications().requestPermissionToSendNotifications(
//       channelKey: NotificationUtils.notificationChannelKey,
//     );
//     if (Platform.isIOS) {
//       await FirebaseMessaging.instance.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//       // ignore: unused_local_variable
//       final _permissionValue =
//           await PermissionUtils.notificationPermissionAvailable;
//       if (!_permissionValue) {
//         showPopUpDialog(
//           context: context,
//           message:
//               "We need notification permission to send timely update about the app. You will be redirected to App Settings, Please allow notification permission from there.",
//           title: "Permission Denied",
//           buttonCallback: () {
//             openAppSettings();
//           },
//           showCancelButton: true,
//         );
//       }
//     }

//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   Future<void> onBackgroundMessageListened() async {
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("heard notification");
//       if (message.data.isNotEmpty) {
//         final _tempNotificationData =
//             NotificationUtils.convertToLocalPushNofication(message.data);
//         NotificationUtils.handleNavigation(
//             _tempNotificationData, NavigationService.context);
//       }
//     });
//   }

//   // Future<void> onForegroundLocalNotification() async {
//   //   AwesomeNotifications().actionStream.listen((message) {
//   //     if (message.payload?["data"] != null) {
//   //       final _encodedData = message.payload!["data"]!;
//   //       dynamic _decodedData;
//   //       try {
//   //         _decodedData = json.decode(_encodedData);
//   //       } catch (e) {
//   //         _decodedData = _encodedData;
//   //       }
//   //       if (_decodedData is Map) {
//   //         final Map<String, dynamic> _data =
//   //             Map<String, dynamic>.from(_decodedData);
//   //         final _tempNotificationData =
//   //             NotificationUtils.convertToLocalPushNofication(_data);
//   //         NotificationUtils.handleNavigation(
//   //           _tempNotificationData,
//   //           NavigationService.context,
//   //         );
//   //       } else if (_decodedData is String) {
//   //         final _doesFileExist = File(_decodedData).existsSync();
//   //         // if (_doesFileExist) {
//   //         //   OpenFilex.open(_decodedData);
//   //         // }
//   //       }
//   //     }
//   //   });
//   // }
//   Future<void> onForegroundLocalNotification() async {
//     AwesomeNotifications().setListeners(
//       onActionReceivedMethod: (ReceivedAction receivedAction) async {
//         if (receivedAction.payload?["data"] != null) {
//           final _encodedData = receivedAction.payload!["data"]!;
//           dynamic _decodedData;
//           try {
//             _decodedData = json.decode(_encodedData);
//           } catch (e) {
//             _decodedData = _encodedData;
//           }
//           if (_decodedData is Map) {
//             final Map<String, dynamic> _data =
//                 Map<String, dynamic>.from(_decodedData);
//             final _tempNotificationData =
//                 NotificationUtils.convertToLocalPushNofication(_data);
//             NotificationUtils.handleNavigation(
//               _tempNotificationData,
//               NavigationService.context,
//             );
//           } else if (_decodedData is String) {
//             // ignore: unused_local_variable
//             final _doesFileExist = File(_decodedData).existsSync();
//             // if (_doesFileExist) {
//             //   OpenFilex.open(_decodedData);
//             // }
//           }
//         }
//       },
//     );
//   }

//   Future<void> onNotificationOpenedFromTerminated() async {
//     try {
//       final _message = await FirebaseMessaging.instance.getInitialMessage();
//       await Future.delayed(const Duration(seconds: 2), () {
//         if (_message?.data.isNotEmpty ?? false) {
//           final _tempNotificationData =
//               NotificationUtils.convertToLocalPushNofication(_message!.data);
//           NotificationUtils.handleNavigation(
//               _tempNotificationData, NavigationService.context);
//         }
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> onForegroundMessageListen() async {
//     FirebaseMessaging.onMessage.listen(
//       (RemoteMessage message) async {
//         print("heard message");
//         print(message);
//         print(message.data);
//         final RemoteNotification? notification = message.notification;
//         if (notification != null) {
//           final Map<String, String> _notificationPayload = {
//             "data": message.data.isNotEmpty ? json.encode(message.data) : ""
//           };
//           // ignore: unused_local_variable
//           LocalPushNotification? _pushNotification;
//           // if (message.data.isNotEmpty) {
//           _pushNotification =
//               NotificationUtils.convertToLocalPushNofication(message.data);
//           final _notificationStatus =
//               await AwesomeNotifications().createNotification(
//             content: NotificationContent(
//               title: notification.title,
//               body: notification.body,
//               displayOnForeground: true,
//               // payload: NotificationContent(id: id, channelKey: channelKey),
//               id: Random().nextInt(1000),
//               channelKey: NotificationUtils.notificationChannelKey,
//               autoDismissible: false,
//               category: NotificationCategory.Event,
//               wakeUpScreen: true,
//               displayOnBackground: true,
//               notificationLayout: NotificationLayout.BigText,
//             ),
//           );
//           print("Notification Status $_notificationStatus");
//           // }
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/models/local_notification.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/notification_utils.dart';
import 'package:ismart/common/util/permission_utils.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:permission_handler/permission_handler.dart';

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
    if (!kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDtxGZ63t5k5Fq3Or-3NESUSkYDsBL885I',
          appId: '1:484503989430:android:1bc2ea328370b4284aca17',
          messagingSenderId: '484503989430',
          projectId: 'ismart-7d185',
          storageBucket: 'myapp-b9yt18.appspot.com',
        ),
      );
    }
  }

  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      initialiseFirebase().then((value) {
        userRepository = RepositoryProvider.of<UserRepository>(context);
        initialiseFCM();
        registerFirebaseBackgroundNotification();
        registerFirebaseToken();

        AwesomeNotifications().initialize(
          null,
          [
            NotificationChannel(
              channelGroupKey: 'notification_group',
              channelKey: NotificationUtils.notificationChannelKey,
              channelName: 'Default Channel',
              channelDescription: 'Default Notifications',
              defaultColor: const Color(0xFF9D50DD),
              ledColor: Colors.white,
            )
          ],
          channelGroups: [
            NotificationChannelGroup(
              channelGroupKey: 'notification_group',
              channelGroupName: 'Notification Group',
            )
          ],
          debug: true,
        );

        listenRefreshToken();
        onForegroundMessageListen();
        onBackgroundMessageListened();
        onNotificationOpenedFromTerminated();
        onForegroundLocalNotification();
      });
    }
  }

  registerFirebaseBackgroundNotification() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  registerFirebaseToken() async {
    final _token = await FirebaseMessaging.instance.getToken();
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
    if (Platform.isAndroid) {
      // Check and request notification permission for Android
      bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: NotificationUtils.notificationChannelKey,
        );
      }
    } else if (Platform.isIOS) {
      // Request notification permission for iOS using Firebase
      final status = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      // Check if permission was denied and show settings dialog
      if (status.authorizationStatus == AuthorizationStatus.denied ||
          status.authorizationStatus == AuthorizationStatus.notDetermined) {
        final permissionStatus = await Permission.notification.status;
        if (permissionStatus.isPermanentlyDenied && mounted) {
          showPopUpDialog(
            context: context,
            message:
                "We need notification permission to send timely updates. Please enable it in settings.",
            title: "Permission Required",
            buttonCallback: () => openAppSettings(),
            showCancelButton: true,
          );
        }
      }
    }

    // Configure notification presentation options
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> onBackgroundMessageListened() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        final notification =
            NotificationUtils.convertToLocalPushNofication(message.data);
        NotificationUtils.handleNavigation(
            notification, NavigationService.context);
      }
    });
  }

  Future<void> onForegroundLocalNotification() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (ReceivedAction receivedAction) async {
        if (receivedAction.payload?["data"] != null) {
          final decodedData = json.decode(receivedAction.payload!["data"]!);
          if (decodedData is Map) {
            final notification = NotificationUtils.convertToLocalPushNofication(
                Map<String, dynamic>.from(decodedData));
            NotificationUtils.handleNavigation(
                notification, NavigationService.context);
          }
        }
      },
    );
  }

  Future<void> onNotificationOpenedFromTerminated() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message?.data != null) {
      final notification =
          NotificationUtils.convertToLocalPushNofication(message!.data);
      NotificationUtils.handleNavigation(
          notification, NavigationService.context);
    }
  }

  Future<void> onForegroundMessageListen() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;
      final data = message.data;

      if (notification != null) {
        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: Random().nextInt(1000),
            channelKey: NotificationUtils.notificationChannelKey,
            title: notification.title,
            body: notification.body,
            payload: {"data": json.encode(data)},
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
