import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/statement/screen/statement_page.dart';

class BankingWidget extends StatelessWidget {
  BankingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    return PageWrapper(
      padding: EdgeInsets.zero,
      showAppBar: false,
      body: CommonContainer(
          showRoundBotton: false,
          showBackBotton: false,
          topbarName: "Banking",
          showTitleText: false,
          body: Container(
            height: _height * 0.6,
            child: GridView.builder(
              itemCount: itemName.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => CommonGridViewContainer(
                onContainerPress: () {
                  NavigationService.pushNamed(routeName: onPress[index]);
                },
                margin: const EdgeInsets.all(8),
                containerImage: images[index],
                title: itemName[index],
              ),
            ),
          )),
    );
  }

  final itemName = [
    "Account Info",
    "Balance Inquiry",
    "Statement",
    "Loan",
    "Fund Transfer",
    "Cheque Request"
  ];
  final images = [
    Assets.accountInfo,
    Assets.balanceInquiry,
    Assets.statement,
    Assets.loanIcon,
    Assets.fundTransferIcon,
    Assets.chequeBookIcon,
  ];
  final onPress = [
    Routes.profileScreen,
    Routes.balanceInquiry,
    Routes.statementPage,
    Routes.profileScreen,
    Routes.anyBank,
    Routes.profileScreen,
  ];
}
