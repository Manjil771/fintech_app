import 'package:flutter/material.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/all_service_screen.dart';
import 'package:ismart/feature/onboard/ui/screen/onboard_page.dart';
import 'package:ismart/feature/profile/screen/profile_page.dart';
import 'package:ismart/feature/receiveMoney/connectIps/screen/connect_ips_page.dart';
import 'package:ismart/feature/receiveMoney/internetBanking/screen/internet_banking_page.dart';
import 'package:ismart/feature/receiveMoney/loadViacard/screen/load_via_card_page.dart';
import 'package:ismart/feature/receiveMoney/mobileBanking/screen/mobile_bannking_page.dart';
import 'package:ismart/feature/receiveMoney/requestSapati/screen/request_sapati_page.dart';
import 'package:ismart/feature/receiveMoney/screens/receive_money_page.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/any_bank_page.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/screen/internal_cooperative_page.dart';
import 'package:ismart/feature/sendMoney/otherCooperative/screen/other_cooperative_page.dart';
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
      case Routes.internalCooperative:
        return MaterialPageRoute(
          builder: (_) => const InternalCooperativePage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.otherCooperative:
        return MaterialPageRoute(
          builder: (_) => const OtherCooperativePage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.reveiveMoney:
        return MaterialPageRoute(
          builder: (_) => const ReceiveMoneyPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.mobileBanking:
        return MaterialPageRoute(
          builder: (_) => const MobileBankingPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.connectIps:
        return MaterialPageRoute(
          builder: (_) => const ConnectIpsPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.loadViaCard:
        return MaterialPageRoute(
          builder: (_) => const LoadViaCardPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.internetbanking:
        return MaterialPageRoute(
          builder: (_) => const InternetBankingPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.requestSapati:
        return MaterialPageRoute(
          builder: (_) => const RequestSapatiPage(),
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
