import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/ui/screens/wallet_transfer_screen.dart';

class SendMoneyWidget extends StatelessWidget {
  const SendMoneyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
          showDetail: false,
          showTitleText: false,
          horizontalPadding: 0,
          body: Column(
            children: [
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.pushNamed(routeName: Routes.anyBank);
                },
                title: "Any Bank",
                detail: "Send Money to accounts maintained at different banks",
                leadingIcon: Assets.bankTransfer,
              ),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.pushNamed(
                      routeName: Routes.internalCooperative);
                },
                title: "Internal Cooperative",
                detail: "Send Money to accounts maintained at same banks",
                leadingIcon: Assets.bankTransfer,
              ),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.pushNamed(
                      routeName: Routes.otherCooperative);
                },
                title: "Other Cooperative",
                detail:
                    "Send Money to accounts maintained at different Cooperative",
                leadingIcon: Assets.bankTransfer,
              ),
              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  NavigationService.push(
                    target: const WalletTransferScreen(),
                  );
                },
                title: "Wallet",
                detail: "Check balance on your wallets",
                leadingIcon: Assets.walletIcon,
              )
            ],
          ),
          showRoundBotton: false,
          topbarName: "Send Money"),
    );
  }
}
