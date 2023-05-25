import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';

class ServicesWidget extends StatelessWidget {
  final bool showAllService;
  ServicesWidget({Key? key, this.showAllService = true}) : super(key: key);
  final screens = [
    Routes.mobileTopup,
    Routes.electricityPayment,
    Routes.internetList,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
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
                  NavigationService.pushNamed(routeName: screens[index]);
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
                    NavigationService.pushNamed(
                        routeName: Routes.allServicesDashboard);
                  },
                  child: const Text("View More"))
        ],
      ),
    );
  }
}
