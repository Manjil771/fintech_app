// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:ismart/app/notification_wrapper.dart';
// import 'package:ismart/app/theme.dart';
// import 'package:ismart/app/update_wrapper.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/route/route_generator.dart';
// import 'package:ismart/common/route/routes.dart';
// import 'package:ismart/common/util/hive_utils.dart';
// import 'package:ismart/common/widget/global_error_widget.dart';
// import 'package:ismart/common/wrapper/multi_bloc_wrapper.dart';
// import 'package:ismart/common/wrapper/multi_repository_wrapper.dart';
// import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
// import 'package:local_session_timeout/local_session_timeout.dart';

// class AppProd extends StatefulWidget {
//   final CoOperative env;
//   const AppProd({Key? key, required this.env}) : super(key: key);

//   @override
//   _AppProdState createState() => _AppProdState();
// }

// class _AppProdState extends State<AppProd> {
//   SessionConfig? sessionConfig;
//   @override
//   void initState() {
//     CustomTheme().initializeTheme(widget.env.primaryColor);

//     ServiceHiveUtils.init();

//     sessionConfig = SessionConfig(
//       invalidateSessionForAppLostFocus: const Duration(minutes: 2),
//     );
//     sessionConfig!.stream.listen((SessionTimeoutState timeoutEvent) {
//       print("Listening for session time out");
//       if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
//         NavigationService.pushReplacement(
//           target: const LoginPage(),
//         );
//       }
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     ServiceHiveUtils.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiRepositoryWrapper(
//       env: widget.env,
//       child: MultiBlocWrapper(
//         env: widget.env,
//         child: NotificationWrapper(
//           child: UpdateWrapper(
//             child: GestureDetector(
//               behavior: HitTestBehavior.translucent,
//               onTap: () {
//                 final FocusScopeNode currentFocus = FocusScope.of(context);

//                 if (!currentFocus.hasPrimaryFocus &&
//                     currentFocus.focusedChild != null) {
//                   FocusManager.instance.primaryFocus?.unfocus();
//                 }
//               },
//               child: MaterialApp(
//                 locale: context.locale,
//                 navigatorKey: NavigationService.navigationKey,
//                 builder: (context, Widget? widget) {
//                   setErrorBuilder(context);
//                   return widget!;
//                 },
//                 supportedLocales: context.supportedLocales,
//                 localizationsDelegates: context.localizationDelegates,
//                 debugShowCheckedModeBanner: false,
//                 darkTheme: CustomTheme.lightTheme,
//                 theme: CustomTheme.lightTheme,
//                 title: widget.env.appTitle,
//                 initialRoute: Routes.root,
//                 onGenerateRoute: RouteGenerator.generateRoute,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/app/notification_wrapper.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/app/update_wrapper.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/route_generator.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/hive_utils.dart';
import 'package:ismart/common/widget/global_error_widget.dart';
import 'package:ismart/common/wrapper/multi_bloc_wrapper.dart';
import 'package:ismart/common/wrapper/multi_repository_wrapper.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

class AppProd extends StatefulWidget {
  final CoOperative env;
  const AppProd({Key? key, required this.env}) : super(key: key);

  @override
  _AppProdState createState() => _AppProdState();
}

class _AppProdState extends State<AppProd> with WidgetsBindingObserver {
  SessionConfig? sessionConfig;
  Timer? debugTimer;
  DateTime? lastActivityTime;
  DateTime? backgroundTime;
  bool isInBackground = false;
  StreamSubscription? sessionSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    CustomTheme().initializeTheme(widget.env.primaryColor);
    ServiceHiveUtils.init();
    sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(minutes: 2),
      invalidateSessionForUserInactivity: const Duration(minutes: 2),
    );
    sessionSubscription =
        sessionConfig!.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        NavigationService.pushReplacement(
          target: const LoginPage(),
        );
      }
    });
    lastActivityTime = DateTime.now();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final now = DateTime.now();
    switch (state) {
      case AppLifecycleState.resumed:
        isInBackground = false;
        backgroundTime = null;
        lastActivityTime = now;
        break;
      case AppLifecycleState.paused:
        isInBackground = true;
        backgroundTime = now;
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugTimer?.cancel();
    sessionSubscription?.cancel();
    ServiceHiveUtils.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryWrapper(
      env: widget.env,
      child: MultiBlocWrapper(
        env: widget.env,
        child: NotificationWrapper(
          child: UpdateWrapper(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                final FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
              child: MaterialApp(
                locale: context.locale,
                navigatorKey: NavigationService.navigationKey,
                builder: (context, Widget? widget) {
                  setErrorBuilder(context);
                  return widget!;
                },
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
                debugShowCheckedModeBanner: false,
                darkTheme: CustomTheme.lightTheme,
                theme: CustomTheme.lightTheme,
                title: widget.env.appTitle,
                initialRoute: Routes.root,
                onGenerateRoute: RouteGenerator.generateRoute,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
