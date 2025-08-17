import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/allremittance_details_page.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/remittance_details_page.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/remittancepayment_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import 'remittance_box_deign.dart';

class ReceiveRemittanceWidget extends StatefulWidget {
  const ReceiveRemittanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ReceiveRemittanceWidget> createState() =>
      _ReceiveRemittanceWidgetState();
}

class _ReceiveRemittanceWidgetState extends State<ReceiveRemittanceWidget> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      body: CommonContainer(
        showRecentTransaction: true,
        verticalPadding: 0,
        body: BlocBuilder<UtilityPaymentCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonStateSuccess<UtilityResponseData>) {
              final List res = state.data.findValue(primaryKey: "data");
              final imeRemit =
                  res.where((item) => item["bankName"] == "IME REMIT").toList();
              final cityExpress = res
                  .where((item) =>
                      item["bankName"] == "CITY EXPRESS MONEY TRANSFER")
                  .toList();
              final others = res
                  .where((item) =>
                      item["bankName"] != "IME REMIT" &&
                      item["bankName"] != "CITY EXPRESS MONEY TRANSFER")
                  .toList();
              final List reorderedList = [
                ...imeRemit,
                ...cityExpress,
                ...others
              ];

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  CustomTheme.white.withAlpha(255)),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: CustomTheme.primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              _showSheet(
                                context,
                              );
                            },
                            child: Text(
                              'Remit Pay',
                              style: TextStyle(color: CustomTheme.primaryColor),
                            ),
                          )),
                    ],
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: reorderedList.length,
                      itemBuilder: (context, index) {
                        return RemitBoxDesign(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          onContainerPress: () {
                            NavigationService.push(
                                target: RemittanceDetailsPage(
                              companyID: reorderedList[index]["locationName"],
                              imagePath: reorderedList[index]["remitLogo"],
                              bankName: reorderedList[index]["bankName"],
                            ));
                          },
                          title: reorderedList[index]["bankName"],
                          imageUrl: reorderedList[index]["remitLogo"],
                        );
                      }),
                ],
              );
            } else if (state is CommonLoading) {
              return const CommonLoadingWidget();
            } else {
              return const NoDataScreen(
                  title: "Not Found", details: "No remit list found.");
            }
          },
        ),
        topbarName: " All Remittance",
        showRoundBotton: false,
        showTitleText: false,
      ),
    );
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          minChildSize: 0.3,
          maxChildSize: 0.8,
          initialChildSize: 0.5,
          builder: (context, scrollController) {
            return AllremittanceDetailsPage(scrollController: scrollController);
          },
        );
      },
    );
  }
}
