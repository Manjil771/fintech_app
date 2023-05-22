import 'package:ismart/common/route/routes.dart';
import 'package:ismart/feature/dashboard/ui/screens/dashboard_page.dart';
import 'package:ismart/feature/onboard/ui/screen/onboard_page.dart';
import 'package:ismart/feature/services/Topup/ui/screens/mobile_topup.dart';
import 'package:ismart/feature/splash/ui/widgets/splash_screen.dart';
import 'package:flutter/material.dart';

import '../widget/transactipon_pin_screen.dart';

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
      case Routes.mobileTopup:
        return MaterialPageRoute(
            builder: (_) => MobileTopupScreen(),
            settings: RouteSettings(name: settings.name));
      case Routes.transactionPinScreen:
        return MaterialPageRoute(
            builder: (_) => TransactionPinScreen(),
            settings: RouteSettings(name: settings.name));
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreens(),
          settings: RouteSettings(name: settings.name),
        );
    }
  }
}
