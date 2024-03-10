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
import 'package:ismart/common/wrapper/multi_bloc_wrapper.dart';
import 'package:ismart/common/wrapper/multi_repository_wrapper.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
import 'package:local_session_timeout/local_session_timeout.dart';

class AppDev extends StatefulWidget {
  final CoOperative env;
  const AppDev({Key? key, required this.env}) : super(key: key);

  @override
  _AppDevState createState() => _AppDevState();
}

class _AppDevState extends State<AppDev> {
  SessionConfig? sessionConfig;
  @override
  void initState() {
    ServiceHiveUtils.init();
    CustomTheme().initializeTheme(widget.env.primaryColor);
    sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(minutes: 2),
    );
    sessionConfig!.stream.listen((SessionTimeoutState timeoutEvent) {
      print("Listening for session time out");
      if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        NavigationService.pushReplacement(
          target: const LoginPage(),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
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
            child: SessionTimeoutManager(
              sessionConfig: sessionConfig,
              child: MaterialApp(
                locale: context.locale,
                navigatorKey: NavigationService.navigationKey,
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
