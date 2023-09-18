import 'package:flutter/material.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/feature/authentication/ui/resetPin/screen/reset_pin_screen.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
import 'package:ismart/feature/banking/balanceInquiry/widget/balance_inquiry_widget.dart';
import 'package:ismart/feature/banking/cheque/screen/cheque_screen.dart';
import 'package:ismart/feature/banking/balanceInquiry/screen/balance_inquiry_page.dart';
import 'package:ismart/feature/banking/loan/loanSchedule/page/loan_schedule_page.dart';
import 'package:ismart/feature/banking/loan/loanStatement/page/loan_statement_choose_account_page.dart';
import 'package:ismart/feature/banking/loan/loanStatement/page/loan_statement_page.dart';
import 'package:ismart/feature/banking/loan/screen/loan_page.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/buy_datapack_screen.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/select_datapack_screen.dart';
import 'package:ismart/feature/categoryWiseService/landline/screen/landline_payment_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/all_category_screen.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/more/discountCalculator/discount_calculator_page.dart';
import 'package:ismart/feature/more/download/screens/downloads_page.dart';
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
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/ui/screens/find_username_internet_screen.dart';
import 'package:ismart/feature/categoryWiseService/internet/ui/screens/internet_list_screen.dart';
import 'package:ismart/feature/setting/screen/setting_page.dart';
import 'package:ismart/feature/splash/ui/widgets/splash_screen.dart';
import 'package:ismart/feature/statement/fullStatement/ui/screen/choose_account_full_statement_page.dart';
import 'package:ismart/feature/statement/fullStatement/ui/screen/full_statement_page.dart';
import 'package:ismart/feature/statement/miniStatement/ui/screen/choose_account_mini_statement_page.dart';
import 'package:ismart/feature/statement/miniStatement/ui/screen/mini_statement_page.dart';
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
      case Routes.loginPage:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.listWalletScreen:
        return MaterialPageRoute(
          builder: (_) => const WalletTransferScreen(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.buyDatapack:
        return MaterialPageRoute(
          builder: (_) => const BuyDatapackScreen(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.chooseAccountFullStatement:
        return MaterialPageRoute(
          builder: (_) => const ChooseAccountFullStatementPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.fullStatement:
        return MaterialPageRoute(
          builder: (_) => FullStatementPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.chooseAccountMiniStatement:
        return MaterialPageRoute(
          builder: (_) => const ChooseAccountMiniStatementPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.miniStatement:
        return MaterialPageRoute(
          builder: (_) => const MiniStatementPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.downloadScreen:
        return MaterialPageRoute(
          builder: (_) => const DownloadPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.forgotPin:
        return MaterialPageRoute(
          builder: (_) => const ResetPinPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.settingPage:
        return MaterialPageRoute(
          builder: (_) => const SettingPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.loanPage:
        return MaterialPageRoute(
          builder: (_) => const LoanPage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.loanSchedulePage:
        return MaterialPageRoute(
          builder: (_) => const LoanSchedulePage(),
          settings: RouteSettings(name: settings.name),
        );
      case Routes.loanStatementPage:
        return MaterialPageRoute(
          builder: (_) => const LoanStatementChooseAccountPage(),
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
