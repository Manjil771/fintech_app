import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class BankingWidget extends StatelessWidget {
  BankingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    return PageWrapper(
      showAppBar: false,
      body: CommonContainer(
          showRoundBotton: false,
          showBackBotton: false,
          topbarName: "Banking",
          showTitleText: false,
          body: Container(
            height: _height * 1,
            child: GridView.builder(
              itemCount: itemName.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => CommonGridViewContainer(
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
}
