import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/ismart_top_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/authentication/ui/screens/login_page.dart';
import 'package:ismart/feature/services/Topup/ui/screens/mobile_topup.dart';
import 'package:ismart/feature/services/Topup/ui/widgets/mobile_topup_widget.dart';
import '../../../../common/widget/custom_pin_field.dart';

class DashboardWidget extends StatelessWidget {
  DashboardWidget({Key? key}) : super(key: key);
// final screens = [
//     MobileTopUp(),
//     const ElectricityPayment(),
//     InternetPayment(),
//     BookFlight(),
//     const WaterPayment(),
//     InsurancePayment(),
//     const BusPayment(),
//     TelevisionPayment(),
//     DataPack(),
//     const RidePayment(),
//     GovernmentPayment(),
//     const BrokerPayment(),
//     const LandLine()
//   ];

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
          Expanded(
            child: GridView.builder(
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  NavigationService.push(target: MobileTopUpWidget());
                },
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/${images[index]}",
                      height: size.height * 0.03,
                    ),
                    SizedBox(height: size.height * 0.02),
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
        ],
      ),
    );
  }
}
