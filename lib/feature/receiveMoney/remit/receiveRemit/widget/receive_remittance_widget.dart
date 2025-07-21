import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/remittance_details_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import 'remittance_box_deign.dart';

class ReceiveRemittanceWidget extends StatelessWidget {
  const ReceiveRemittanceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      body: CommonContainer(
        horizontalPadding: 4,
        verticalPadding: 0,
        body: BlocBuilder<UtilityPaymentCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonStateSuccess<UtilityResponseData>) {
              final List res = state.data.findValue(primaryKey: "data");
              return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: res.length,
                  itemBuilder: (context, index) {
                    return RemitBoxDesign(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      onContainerPress: () {
                        NavigationService.push(
                            target: RemittanceDetailsPage(
                          companyID: res[index]["locationName"],
                        ));
                      },
                      title: res[index]["bankName"],
                      imageUrl: res[index]["remitLogo"],
                    );
                  });
            } else if (state is CommonLoading) {
              return const CommonLoadingWidget();
            } else {
              return const NoDataScreen(
                  title: "Not Found", details: "No remit list found.");
            }
          },
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
