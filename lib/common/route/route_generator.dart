import 'package:flutter/material.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/feature/banking/balanceInquiry/widget/balance_inquiry_widget.dart';
import 'package:ismart/feature/banking/cheque/screen/cheque_screen.dart';
import 'package:ismart/feature/banking/balanceInquiry/screen/balance_inquiry_page.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/buy_datapack_screen.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/select_datapack_screen.dart';
import 'package:ismart/feature/categoryWiseService/landline/screen/landline_payment_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/all_category_screen.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/more/discountCalculator/discount_calculator_page.dart';
import 'package:ismart/feature/more/emiCalculator/emi_calculator_page.dart';
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
import 'package:ismart/feature/sendMoney/wallet_transfer/ui/screens/wallet_transfer_screen.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_payment_detail_page.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/ui/screens/find_username_internet_screen.dart';
import 'package:ismart/feature/categoryWiseService/internet/ui/screens/internet_list_screen.dart';
import 'package:ismart/feature/splash/ui/widgets/splash_screen.dart';
import 'package:ismart/feature/statement/screen/statement_page.dart';

import '../../feature/categoryWiseService/Topup/ui/screens/mobile_topup_page.dart';

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
          builder: (_) => const MobileTopupPage(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.allServicesDashboard:
        return MaterialPageRoute(
          builder: (_) => const AllCategoryScreen(),
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
      case Routes.statementPage:
        return MaterialPageRoute(
          builder: (_) => const StatementPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.balanceInquiry:
        return MaterialPageRoute(
          builder: (_) => const BalanceInquiryWidget(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.chequeScreen:
        return MaterialPageRoute(
          builder: (_) => const ChequePage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.emiCalculator:
        return MaterialPageRoute(
          builder: (_) => EmiCalculatorPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.discountCalculator:
        return MaterialPageRoute(
          builder: (_) => DiscountCalculatorPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.listWalletScreen:
        return MaterialPageRoute(
          builder: (_) => const WalletTransferScreen(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.selectDataPack:
        return MaterialPageRoute(
          builder: (_) => const SelectDatapackScreen(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.buyDatapack:
        return MaterialPageRoute(
          builder: (_) => const BuyDatapackScreen(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.landlineScreen:
        return MaterialPageRoute(
          builder: (_) => const LandlinePaymentPage(),
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
