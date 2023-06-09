import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class ReceiveMoneyWidget extends StatelessWidget {
  const ReceiveMoneyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
          showDetail: true,
          showTitleText: false,
          horizontalPadding: 0,
          body: Column(
            children: [
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.pushNamed(routeName: Routes.mobileBanking);
                },
                title: "Mobile Banking",
                detail: "Make financial transactions using your phone",
                leadingIcon: Assets.mobileBanking,
              ),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.pushNamed(
                      routeName: Routes.internetbanking);
                },
                title: "Internet Banking",
                detail:
                    "Make financial transactions through internet using your preferred devices.",
                leadingIcon: Assets.bankTransfer,
              ),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.pushNamed(routeName: Routes.loadViaCard);
                },
                title: "Load via Card",
                detail: "Load fund instantly from the card.",
                leadingIcon: Assets.cardIcon,
              ),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.pushNamed(routeName: Routes.connectIps);
                },
                title: "Connect IPS",
                detail: "Send Money using Connect IPS.",
                leadingIcon: Assets.connectIpsIcon,
              ),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.pushNamed(routeName: Routes.requestSapati);
                },
                title: "Request Sapati",
                detail: "Lend money from your friends using app",
                leadingIcon: Assets.sapatiIcon,
              ),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {},
                title: "Remittance",
                detail: "Send Money using Connect IPS.",
                leadingIcon: Assets.remittanceIcon,
              )
            ],
          ),
          showRoundBotton: false,
          topbarName: "Receive Money"),
    );
  }
}
