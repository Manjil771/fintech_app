import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class RemittanceWidget extends StatelessWidget {
  const RemittanceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 0,
        body: Column(
          children: [
            CommonDetailBox(
              leadingImage: Assets.sendMoneyRemit,
              onBoxPressed: () {},
              title: "Send Money",
              detail: "Cash out your balance from our nearby agents",
            ),
            Divider(),
            CommonDetailBox(
              leadingImage: Assets.receiveMoneyRemit,
              onBoxPressed: () {},
              title: "Receive Money",
              detail: "Receive Remittance directly on your bank",
            ),
            Divider(),
            CommonDetailBox(
              leadingImage: Assets.findAgentsRemit,
              onBoxPressed: () {},
              title: "Find Agent",
              detail: "Cash out your balance from our nearby agents",
            ),
            Divider(),
            CommonDetailBox(
              leadingImage: Assets.trackMoneyRmit,
              onBoxPressed: () {},
              title: "Track Money",
              detail: "Track status of your money transfer",
            ),
            Divider(),
          ],
        ),
        topbarName: "Remittance",
        showRoundBotton: false,
        showTitleText: false,
      ),
    );
  }
}
