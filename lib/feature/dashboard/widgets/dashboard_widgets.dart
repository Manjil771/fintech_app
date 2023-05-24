import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/widgets/dashboard_tabbar_widget.dart';
import 'package:ismart/feature/dashboard/widgets/dashboard_user_widget.dart';
import 'package:ismart/feature/services/Topup/ui/screens/mobile_topup.dart';
import 'package:ismart/feature/services/internet/ui/screens/internet_list_screen.dart';

class DashboardWidget extends StatelessWidget {
  DashboardWidget({Key? key}) : super(key: key);
  final screens = [
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    InternetListScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
    const MobileTopupScreen(),
  ];

  final List images = [
    "Top up payment.svg",
    "Electricity payment.svg",
    "internet payment.svg",
    "airline.svg",
    "drinking Water payment.svg",
    "Insurance payment.svg",
    "Bus payment.svg",
    "TV Payment.svg",
    "Data pack.svg",
    "ride.svg",
    "Government payment.svg",
    "broker.svg",
    "landline-1-svgrepo-com 1.svg",
  ];
  final names = [
    "Top Up",
    "Electricity",
    "Internet",
    "Air Ticket",
    "Water",
    "Insurance",
    "Bus Ticket",
    "Television",
    "Data Packs",
    "Ride",
    "Government Payment",
    "Broker",
  ];

  final image = CoOperativeValue.development.bannerImage;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      // showAppBar: true,
      body: Column(
        children: [
          const DashBoardUserWidget(),
          SizedBox(height: _height * 0.02),
          Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: CustomTheme.white,
                    borderRadius: BorderRadius.circular(12)),
                height: _height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: _theme.primaryColor.withOpacity(0.16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          Assets.sendMoneyIcon,
                          color: _theme.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: _width * 0.02),
                    const Text("Send"),
                  ],
                ),
              )),
              SizedBox(width: _width * 0.2),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: CustomTheme.white,
                    borderRadius: BorderRadius.circular(12)),
                height: _height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: _theme.primaryColor.withOpacity(0.16),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          Assets.reveiceMoneyIcon,
                          color: _theme.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: _width * 0.02),
                    const Text("Receive"),
                  ],
                ),
              ))
            ],
          ),
          const Expanded(child: DashboardTabbarWidget())
        ],
      ),
    );
  }
}
