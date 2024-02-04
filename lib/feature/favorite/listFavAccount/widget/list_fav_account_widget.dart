import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/favorite/addAccount/screen/add_fav_account_page.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/any_bank_page.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/screen/internal_cooperative_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ListFavAccountWidget extends StatelessWidget {
  ListFavAccountWidget({super.key});
  bool isBankTransfer = true;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
        backgroundColor: CustomTheme.white,
        showAppBar: false,
        padding: EdgeInsets.zero,
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  child: Text(
                    "Add Account",
                    style: _textTheme.displaySmall!
                        .copyWith(fontSize: 12, color: _theme.primaryColor),
                  ),
                  onPressed: () {
                    NavigationService.push(target: AddFavAccountPage());
                  }),
            ),
            Expanded(
              child: BlocBuilder<UtilityPaymentCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonStateSuccess<UtilityResponseData>) {
                    final res = state.data.findValue(primaryKey: "data");

                    if (res.isNotEmpty) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: res.length,
                              itemBuilder: (context, index) {
                                final bool isBankTransfer =
                                    res[index]["serviceInfoType"].toString() ==
                                            "CONNECT_IPS"
                                        ? true
                                        : false;
                                return InkWell(
                                  onTap: () {
                                    isBankTransfer == true
                                        ? NavigationService.push(
                                            target: AnyBankpage(
                                            accountName: res[index]["data"]
                                                ["destinationAccountName"],
                                            accountNumber: res[index]["data"]
                                                ["destinationAccountNumber"],
                                            bankCode: res[index]["data"]
                                                ["destinationBankCode"],
                                            bankName: res[index]["data"]
                                                ["destinationBankName"],
                                          ))
                                        : NavigationService.push(
                                            target: InternalCooperativePage(
                                            branchId: res[index]["data"]
                                                ["destinationBankCode"],
                                            isFavAccount: true,
                                            branchName: res[index]["data"]
                                                ["destinationBankName"],
                                            accountName: res[index]["data"]
                                                ["destinationAccountName"],
                                            accountNumber: res[index]["data"]
                                                ["destinationAccountNumber"],
                                            branchCode: res[index]["data"]
                                                ["destinationBranchCode"],
                                          ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(12),
                                      // color: _theme.primaryColor.withOpacity(0.1)
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  res[index]["data"][
                                                      "destinationAccountName"],
                                                  style: _textTheme.labelLarge!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                                Text(
                                                  (isBankTransfer
                                                          ? "Connect IPS "
                                                          : "Fund Transfer ") +
                                                      res[index]["data"][
                                                          "destinationAccountNumber"],
                                                  style: _textTheme.labelLarge!
                                                      .copyWith(
                                                          color: _theme
                                                              .primaryColor,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                                Text(
                                                  res[index]["data"][
                                                          "destinationBankName"]
                                                      .toString(),
                                                  style: _textTheme.labelLarge!
                                                      .copyWith(
                                                          color: _theme
                                                              .primaryColor,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ]),
                                        ),
                                        SvgPicture.asset(
                                          Assets.arrowRight,
                                          height: 12.hp,
                                          width: 12.wp,
                                          color: _theme.primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return NoDataScreen(
                          showImage: false,
                          title: "No Account Found",
                          details:
                              "No favorite account found . Please try again later.");
                    }
                  }
                  if (state is CommonLoading) {
                    return CommonLoadingWidget();
                  } else {
                    return Column(
                      children: [
                        NoDataScreen(
                            showImage: false,
                            title: "No Account Found",
                            details:
                                "No favorite account found . Please try again later."),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
