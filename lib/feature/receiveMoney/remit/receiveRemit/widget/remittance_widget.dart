import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

import 'remittance_box_deign.dart';

class ReceiveRemittanceWidget extends StatelessWidget {
  const ReceiveRemittanceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 0,
        body: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => const RemitBoxDesign(
            title: "Money Gram",
            containerImage: "assets/Asset 1.png",
          ),
        ),
        topbarName: "Remittance",
        showRoundBotton: false,
        showTitleText: false,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:ismart/common/constant/assets.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/common_detail_box.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';

// class ReceiveRemittanceWidget extends StatelessWidget {
//   const ReceiveRemittanceWidget({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     return PageWrapper(
//       body: CommonContainer(
//         verticalPadding: 0,
//         body: Column(
//           children: [
//             CommonDetailBox(
//               leadingImage: Assets.sendMoneyRemit,
//               onBoxPressed: () {},
//               title: "Send Money",
//               detail: "Cash out your balance from our nearby agents",
//             ),
//             const Divider(),
//             CommonDetailBox(
//               leadingImage: Assets.receiveMoneyRemit,
//               onBoxPressed: () {},
//               title: "Receive Money",
//               detail: "Receive Remittance directly on your bank",
//             ),
//             const Divider(),
//             CommonDetailBox(
//               leadingImage: Assets.findAgentsRemit,
//               onBoxPressed: () {},
//               title: "Find Agent",
//               detail: "Cash out your balance from our nearby agents",
//             ),
//             const Divider(),
//             CommonDetailBox(
//               leadingImage: Assets.trackMoneyRmit,
//               onBoxPressed: () {},
//               title: "Track Money",
//               detail: "Track status of your money transfer",
//             ),
//             const Divider(),
//           ],
//         ),
//         topbarName: "Remittance",
//         showRoundBotton: false,
//         showTitleText: false,
//       ),
//     );
//   }
// }
