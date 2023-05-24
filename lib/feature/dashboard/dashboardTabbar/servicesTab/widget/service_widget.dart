import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/dashboard/dashboardTabbar/servicesTab/screen/all_service_screen.dart';
import 'package:ismart/feature/services/internet/ui/screens/internet_list_screen.dart';

import '../../../../services/Topup/ui/screens/mobile_topup.dart';

class ServicesWidget extends StatelessWidget {
  final bool showAllService;
  ServicesWidget({Key? key, this.showAllService = true}) : super(key: key);
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
    Assets.topupPaymentIcon,
    Assets.topupPaymentIcon,
    Assets.electricityIcon,
    Assets.internetIcon,
    Assets.airlineIcon,
    Assets.waterIcon,
    Assets.insuranceIcon,
    Assets.busIcon,
    Assets.tvIcon,
    Assets.dataPackIcon,
    Assets.ridepaymentIcon,
    Assets.governmentIcon,
    Assets.brokerIcon,
    Assets.landlineIcon,
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

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
          color: CustomTheme.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: showAllService ? 12 : 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  NavigationService.push(target: screens[index]);
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "${images[index]}",
                      height: _height * 0.03,
                    ),
                    SizedBox(height: _height * 0.02),
                    Expanded(
                      child: Text(
                        "${names[index]}".toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          showAllService
              ? Container()
              : TextButton(
                  onPressed: () {
                    NavigationService.push(target: const AllServiceScreen());
                  },
                  child: const Text("View More"))
        ],
      ),
    );
  }
}
