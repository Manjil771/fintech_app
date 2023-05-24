import 'package:flutter/material.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/feature/onboard/ui/screen/onboard_page.dart';
import 'package:ismart/feature/services/internet/ui/screens/find_username_internet_screen.dart';
import 'package:ismart/feature/services/internet/ui/screens/internet_list_screen.dart';
import 'package:ismart/feature/splash/ui/widgets/splash_screen.dart';

import '../../feature/services/Topup/ui/screens/mobile_topup.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return MaterialPageRoute(
          builder: (_) => const SplashScreens(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (_) => OnboardPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.internetList:
        return MaterialPageRoute(
          builder: (_) => InternetListScreen(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.mobileTopup:
        return MaterialPageRoute(
          builder: (_) => const MobileTopupScreen(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.internetUsername:
        return MaterialPageRoute(
          builder: (_) => const FindInternetUserScreen(),
          settings: RouteSettings(name: settings.name),
        );
      // case Routes.internetPaymentDetail:
      //   return MaterialPageRoute(
      //     builder: (_) => InternetPaymentDeatilScreen(),
      //     settings: RouteSettings(name: settings.name),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreens(),
          settings: RouteSettings(name: settings.name),
        );
    }
  }
}
