import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

class AccountDetailBox extends StatefulWidget {
  final Function()? onPressed;
  final bool? validateMobileBankingStatus;
  final bool? showRentSavingOnly;
  // ValueNotifier<CustomerDetailModel?> customerDetail;

  const AccountDetailBox({
    super.key,
    this.onPressed,
    this.validateMobileBankingStatus = true,
    this.showRentSavingOnly = false,
  });

  @override
  State<AccountDetailBox> createState() => _AccountDetailBoxState();
}

class _AccountDetailBoxState extends State<AccountDetailBox> {

// @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//         final _customerDetailRepo =
//             RepositoryProvider.of<CustomerDetailRepository>(context);
//           if (
//             widget.showRentSavingOnly == false )  {
//               _customerDetailRepo.selectedAccount.value = _customerDetailRepo.accountsList.value.firstWhere(
//               (account) => account.primary == 'true',
//               orElse: () => _customerDetailRepo.accountsList.value.first);
          
//         }
  
//     });
//   }



  @override
  Widget build(BuildContext context) {
    final _customerDetailRepo =
        RepositoryProvider.of<CustomerDetailRepository>(context);
    // int myIndex = 0;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return ValueListenableBuilder<AccountDetail?>(
      valueListenable: _customerDetailRepo.selectedAccount,
      builder: (context, selectedAccount, _) {
        return ValueListenableBuilder<CustomerDetailModel?>(
          valueListenable: _customerDetailRepo.customerDetailModel,
          builder: (context, val, _) {
            if (val != null) {
               List showValidAccount = [];

              if( widget.showRentSavingOnly == true){
                  showValidAccount = val.accountDetail
                  .where((element) =>
                      element.accountType.toLowerCase() == "rentsaving")
                  .toList();
              } else {
                    showValidAccount = val.accountDetail
                  .where((element) =>
                      element.accountType.toLowerCase() == "saving" ||
                      element.accountType.toLowerCase() == "current" 
                      // ||
                      // (element.accountType.toLowerCase() == "rentsaving" &&
                      //     widget.showRentSavingOnly == true
                          
                      //     )
                      
                      )
                  .toList();

              }
              final List validMobileBankingList =
                  widget.validateMobileBankingStatus == true
                      ? 
                    showValidAccount
                          .where((element) =>
                              element.mobileBanking.toString().toLowerCase() !=
                              "false")
                          .toList()
                      : showValidAccount;

              // final accountsToShow = List.generate(
              //   10,
              //   (i) => AccountDetail(
              //     interestRate: "5%",
              //     accountType: i % 2 == 0 ? "Saving" : "Current",
              //     accountTypeDescription:
              //         i % 2 == 0 ? "Savings Account" : "Current Account",
              //     branchName: "Branch ${i + 1}",
              //     accruedInterest: "100",
              //     accountNumber: "1000$i",
              //     accountHolderName: "John Doe $i",
              //     availableBalance: "${1000 * (i + 1)}",
              //     branchCode: "B00$i",
              //     mainCode: "M00$i",
              //     minimumBalance: "500",
              //     clientCode: "C00$i",
              //     actualBalance: "${1000 * (i + 1)}",
              //     mobileBanking: "true",
              //     sms: "true",
              //     id: "$i",
              //     primary: i == 0 ? "true" : "false",
              //   ),
              // );

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(18),
                      width: double.infinity,
                      // height: _width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: CustomTheme.white,
                        border: Border.all(color: Colors.black45),
                      ),
                      child: Column(
                        children: [
                          if (validMobileBankingList.length > 3)
                            ElevatedButton(
                                onPressed: () {
                                  NavigationService.pop();
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                      color: CustomTheme.primaryColor),
                                )),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: validMobileBankingList.length,
                              itemBuilder: (context, index) {
                                final AccountDetail account =
                                    validMobileBankingList[index];
                                final _isSelectedAccount = account.accountNumber
                                    .toLowerCase()
                                    .contains(
                                        selectedAccount?.accountNumber ?? "");
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        _customerDetailRepo
                                            .selectedAccount.value = account;
                                        NavigationService.pop();
                                        if (widget.onPressed != null)
                                          widget.onPressed!.call();
                                      },
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        padding: const EdgeInsets.all(18),
                                        width: double.infinity,
                                        height: _width * 0.35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: _isSelectedAccount
                                                ? CustomTheme.primaryColor
                                                : CustomTheme.gray,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  Assets.walletIcon,
                                                  height: _height * 0.023,
                                                  color: _theme.primaryColor,
                                                ),
                                                SizedBox(width: _width * 0.03),
                                                Text(
                                                  "NPR ${formatNepaliCurrencyFromString(account.availableBalance)}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily:
                                                          "popinsemibold",
                                                      color:
                                                          _theme.primaryColor),
                                                ),
                                                const Spacer(),
                                                account.primary == "true"
                                                    ? Container(
                                                        width: _width * 0.2,
                                                        height: _width * 0.06,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: _theme
                                                              .primaryColor,
                                                          // border: Border.all(color: Colors.black),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Primary",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  Assets.bankingIcon,
                                                  height: _height * 0.023,
                                                  color: _theme.primaryColor,
                                                ),
                                                SizedBox(width: _width * 0.03),
                                                Expanded(
                                                    child: Text(
                                                  account.accountTypeDescription
                                                          .isNotEmpty
                                                      ? account
                                                          .accountTypeDescription
                                                      : account.accountType,
                                                  maxLines: 2,
                                                  style: _theme
                                                      .textTheme.labelLarge,
                                                )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  Assets.personIcon,
                                                  height: _height * 0.023,
                                                  color: _theme.primaryColor,
                                                ),
                                                SizedBox(width: _width * 0.03),
                                                Text(
                                                  account.mainCode,
                                                  style: _textTheme.labelMedium,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            {
              return Container();
            }
          },
        );
      },
    );
  }

  String formatNepaliCurrencyFromString([String? value]) {
    if (value == null || value.trim().isEmpty) {
      return "";
    }
    final int? amount = int.tryParse(value);
    if (amount == null) {
      return value;
    }
    final String numberStr = amount.toString();
    final int len = numberStr.length;
    if (len <= 3) return numberStr;
    final String lastThree = numberStr.substring(len - 3);
    String remaining = numberStr.substring(0, len - 3);
    final List<String> parts = [];
    while (remaining.length > 2) {
      parts.insert(0, remaining.substring(remaining.length - 2));
      remaining = remaining.substring(0, remaining.length - 2);
    }
    if (remaining.isNotEmpty) {
      parts.insert(0, remaining);
    }
    return parts.join(",") + "," + lastThree;
  }
}
