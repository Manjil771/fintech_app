import 'package:flutter/material.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/feature/dashboard/dashboardTabbar/servicesTab/screen/all_service_screen.dart';
import 'package:ismart/feature/onboard/ui/screen/onboard_page.dart';
import 'package:ismart/feature/profile/screen/profile_page.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/any_bank_page.dart';
import 'package:ismart/feature/sendMoney/screens/send_money_page.dart';
import 'package:ismart/feature/services/electricity/screen/electricity_payment_detail_page.dart';
import 'package:ismart/feature/services/electricity/screen/electricity_payment_page.dart';
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
      case Routes.allServicesDashboard:
        return MaterialPageRoute(
          builder: (_) => const AllServiceScreen(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.sendMoney:
        return MaterialPageRoute(
          builder: (_) => const SendMoneyPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.anyBank:
        return MaterialPageRoute(
          builder: (_) => const AnyBankpage(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.electricityPayment:
        return MaterialPageRoute(
          builder: (_) => const ElectricityPaymentPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.electricityPaymentDetail:
        return MaterialPageRoute(
          builder: (_) => const ElectricityPaymentDetailPage(),
          settings: RouteSettings(name: settings.name),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreens(),
          settings: RouteSettings(name: settings.name),
        );
    }
  }
}
