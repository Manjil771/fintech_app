import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';
import 'package:share_plus/share_plus.dart';

class AccountListProfileWidget extends StatefulWidget {
  final ValueNotifier<CustomerDetailModel?> customerDetail;
  const AccountListProfileWidget({Key? key, required this.customerDetail})
      : super(key: key);

  @override
  State<AccountListProfileWidget> createState() =>
      _AccountListProfileWidgetState();
}

class _AccountListProfileWidgetState extends State<AccountListProfileWidget> {
  bool showPersonalDetail = false;
  Set<int> expandedOtherAccounts = {};
  Set<int> expandedLoanAccounts = {};

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    bool showPrimaryAccount = false;

    filterLoanType(CustomerDetailModel? customerDetail) {
      final List showValidAccount = customerDetail!.accountDetail
          .where((element) =>
              element.accountType.toLowerCase() == "loan" ||
              element.accountType.toLowerCase() == "od")
          .toList();
      return showValidAccount;
    }

    filterOtherType(CustomerDetailModel? customerDetail) {
      final List showValidAccount = customerDetail!.accountDetail
          .where((element) =>
              element.accountType.toLowerCase() != "loan" &&
              element.accountType.toLowerCase() != "od")
          .toList();
      return showValidAccount;
    }

    return PageWrapper(
      padding: EdgeInsets.zero,
      showAppBar: false,
      body: ListView(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filterOtherType(widget.customerDetail.value).length,
              itemBuilder: (context, index) {
                final _detail = filterOtherType(widget.customerDetail.value);
                final accuredInterest =
                    _detail[index].accruedInterest.toString().toLowerCase();
                final interestRate =
                    _detail[index].interestRate.toString().toLowerCase();
                final isExpanded = expandedOtherAccounts.contains(index);

                return Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ExpansionTile(
                        onExpansionChanged: (expanded) {
                          setState(() {
                            if (expanded) {
                              expandedOtherAccounts.add(index);
                            } else {
                              expandedOtherAccounts.remove(index);
                            }
                          });
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.share,
                                size: 18.wp,
                              ),
                              onPressed: () async {
                                await Share.share(
                                  '${(widget.customerDetail.value?.bank?.toString().toLowerCase() != "n/a" && widget.customerDetail.value?.bank?.toString().toLowerCase() != "null") ? '\nCoop Name: ${widget.customerDetail.value?.bank}' : ''}'
                                  '${(_detail[index].accountHolderName.toString().toLowerCase() != "n/a" && _detail[index].accountHolderName.toString().toLowerCase() != "null") ? '\nAccount Holder Name: ${_detail[index].accountHolderName}' : ''}'
                                  '${(_detail[index].accountNumber.toString().toLowerCase() != "n/a" && _detail[index].accountNumber.toString().toLowerCase() != "null") ? '\nAccount Number: ${_detail[index].accountNumber.toString().toLowerCase()}' : ''}'
                                  // '${(_detail[index].mobileNumber.toString().toLowerCase() != "n/a" && _detail[index].mobileNumber.toString().toLowerCase() != "null") ? '\nMobile Number: ${_detail[index].mobileNumber.toString().toLowerCase()}' : ''}'
                                  '${'\nMobile Number: ${RepositoryProvider.of<CustomerDetailRepository>(context).customerDetailModel.value?.mobileNumber}'}'
                                  '${(_detail[index].clientCode.toString().toLowerCase() != "n/a" && _detail[index].clientCode.toString().toLowerCase() != "null") ? '\nMember ID: ${_detail[index].clientCode.toString().toLowerCase()}' : ''}',
                                );
                              },
                              splashRadius: 20,
                            ),
                            // AnimatedRotation(
                            //   turns: isExpanded ? 0.5 : 0,
                            //   duration: const Duration(milliseconds: 300),
                            //   child: const Icon(Icons.expand_more),
                            // ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) =>
                                  RotationTransition(
                                turns: child.key == const ValueKey('+')
                                    ? Tween<double>(begin: 0.75, end: 1)
                                        .animate(animation)
                                    : Tween<double>(begin: 1.25, end: 1)
                                        .animate(animation),
                                child: child,
                              ),
                              child: Icon(
                                isExpanded ? Icons.remove : Icons.add,
                                key: ValueKey(isExpanded ? '-' : '+'),
                              ),
                            )
                          ],
                        ),
                        title: CommonDetailBox(
                            showTrailingIcon: false,
                            leadingImage: Assets.profileIcon,
                            title: (_detail[index]
                                        .accountTypeDescription
                                        ?.isNotEmpty ??
                                    false)
                                ? _detail[index].accountTypeDescription
                                : _detail[index].accountType,
                            detail: "A/C : ${_detail[index].mainCode}",
                            onBoxPressed: () {
                              setState(() {
                                showPrimaryAccount = !showPrimaryAccount;
                              });
                              print(showPrimaryAccount);
                            }),
                        children: [
                          Container(
                            color: _theme.scaffoldBackgroundColor,
                            height: _height * 0.19,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    if (_detail[index]
                                                .actualBalance
                                                .toString()
                                                .toLowerCase() !=
                                            "n/a" ||
                                        _detail[index]
                                                .actualBalance
                                                .toString()
                                                .toLowerCase() !=
                                            "null")
                                      Expanded(
                                        child: buildDetails(
                                            context,
                                            "actual balance profile page.svg",
                                            "Actual Balance",
                                            "NPR ${_detail[index].actualBalance}"),
                                      ),
                                    if (_detail[index]
                                                .availableBalance
                                                .toString()
                                                .toLowerCase() !=
                                            "N/A".toLowerCase() ||
                                        _detail[index]
                                                .availableBalance
                                                .toString()
                                                .toLowerCase() !=
                                            "null")
                                      SizedBox(
                                        width: _width * 0.4,
                                        child: buildDetails(
                                            context,
                                            "money-send-svgrepo-com 1.svg",
                                            "Available Bal.",
                                            "NPR ${_detail[index].availableBalance}"),
                                      ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    if (accuredInterest != "0.0" &&
                                        accuredInterest != "0" &&
                                        accuredInterest != "null" &&
                                        accuredInterest != "n/a" &&
                                        accuredInterest != "N/A" &&
                                        accuredInterest != "")
                                      Expanded(
                                        child: buildDetails(
                                            context,
                                            "accrued interest.svg",
                                            "Accrued Interest",
                                            "NPR ${_detail[index].accruedInterest}"),
                                      ),
                                    if (interestRate != "0" &&
                                        interestRate != "0.0" &&
                                        interestRate != "null" &&
                                        interestRate != "n/a" &&
                                        interestRate != "N/A" &&
                                        interestRate != "")
                                      SizedBox(
                                        width: _width * 0.4,
                                        child: buildDetails(
                                            context,
                                            "interest rate profile.svg",
                                            "Interest Rate",
                                            "${_detail[index].interestRate} %"),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filterLoanType(widget.customerDetail.value).length,
            itemBuilder: (context, index) {
              final loanAccountNumber =
                  filterLoanType(widget.customerDetail.value);
              final isLoanExpanded = expandedLoanAccounts.contains(index);

              return BlocProvider(
                create: (context) => UtilityPaymentCubit(
                    utilityPaymentRepository:
                        RepositoryProvider.of<UtilityPaymentRepository>(
                            context))
                  ..fetchDetails(
                      serviceIdentifier: "",
                      accountDetails: {
                        "accountNumber": loanAccountNumber[index].accountNumber,
                      },
                      shouldIncludeMPIN: true,
                      apiEndpoint: "/api/loan/details"),
                child: BlocBuilder<UtilityPaymentCubit, CommonState>(
                  builder: (context, state) {
                    final _detail = filterLoanType(widget.customerDetail.value);
                    if (state is CommonStateSuccess) {
                      final UtilityResponseData res = state.data;
                      if (res.code == "M0000") {
                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              ExpansionTile(
                                onExpansionChanged: (expanded) {
                                  setState(() {
                                    if (expanded) {
                                      expandedLoanAccounts.add(index);
                                    } else {
                                      expandedLoanAccounts.remove(index);
                                    }
                                  });
                                },
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        size: 18.wp,
                                      ),
                                      onPressed: () async {
                                        await Share.share(
                                          '${(widget.customerDetail.value?.bank?.toString().toLowerCase() != "n/a" && widget.customerDetail.value?.bank?.toString().toLowerCase() != "null") ? '\nCoop Name: ${widget.customerDetail.value?.bank}' : ''}'
                                          '${(_detail[index].accountHolderName.toString().toLowerCase() != "n/a" && _detail[index].accountHolderName.toString().toLowerCase() != "null") ? '\nAccount Holder Name: ${_detail[index].accountHolderName}' : ''}'
                                          '${(_detail[index].accountNumber.toString().toLowerCase() != "n/a" && _detail[index].accountNumber.toString().toLowerCase() != "null") ? '\nAccount Number: ${_detail[index].accountNumber.toString().toLowerCase()}' : ''}'
                                          // '${(_detail[index].mobileNumber.toString().toLowerCase() != "n/a" && _detail[index].mobileNumber.toString().toLowerCase() != "null") ? '\nMobile Number: ${_detail[index].mobileNumber.toString().toLowerCase()}' : ''}'
                                          '${'\nMobile Number: ${RepositoryProvider.of<CustomerDetailRepository>(context).customerDetailModel.value?.mobileNumber}'}'
                                          '${(_detail[index].clientCode.toString().toLowerCase() != "n/a" && _detail[index].clientCode.toString().toLowerCase() != "null") ? '\nMember ID: ${_detail[index].clientCode.toString().toLowerCase()}' : ''}',
                                        );
                                      },
                                      splashRadius: 20,
                                    ),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transitionBuilder: (child, animation) =>
                                          RotationTransition(
                                        turns: child.key == const ValueKey('+')
                                            ? Tween<double>(begin: 0.75, end: 1)
                                                .animate(animation)
                                            : Tween<double>(begin: 1.25, end: 1)
                                                .animate(animation),
                                        child: child,
                                      ),
                                      child: Icon(
                                        isLoanExpanded
                                            ? Icons.remove
                                            : Icons.add,
                                        key: ValueKey(
                                            isLoanExpanded ? '-' : '+'),
                                      ),
                                    )
                                  ],
                                ),
                                title: CommonDetailBox(
                                    showTrailingIcon: false,
                                    leadingImage: Assets.profileIcon,
                                    title: _detail[index]
                                            .accountTypeDescription
                                            .toString()
                                            .isNotEmpty
                                        ? _detail[index].accountTypeDescription
                                        : _detail[index].accountType,
                                    detail: "A/C : ${_detail[index].mainCode}",
                                    onBoxPressed: () {
                                      setState(() {
                                        showPrimaryAccount =
                                            !showPrimaryAccount;
                                      });
                                      print(showPrimaryAccount);
                                    }),
                                children: [
                                  Container(
                                    color: _theme.scaffoldBackgroundColor,
                                    height: _height * 0.19,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: buildDetails(
                                                  context,
                                                  "money-send-svgrepo-com 1.svg",
                                                  "Balance",
                                                  res.findValueString(
                                                      "balance")),
                                            ),
                                            SizedBox(
                                              width: _width * 0.4,
                                              child: buildDetails(
                                                context,
                                                "actual balance profile page.svg",
                                                "Disbursed Amt",
                                                res.findValueString(
                                                    "disbursedAmount"),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: buildDetails(
                                                  context,
                                                  "accrued interest.svg",
                                                  "Interest Rate",
                                                  "${res.findValueString("interestRate")}"),
                                            ),
                                            SizedBox(
                                              width: _width * 0.4,
                                              child: buildDetails(
                                                  context,
                                                  "uit_calender.svg",
                                                  "Duration",
                                                  "${res.findValueString("duration")} "),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
              );
            },
          ),
          SizedBox(height: 10.hp),
        ],
      ),
    );
  }

  buildDetails(BuildContext context, images, title, value) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/$images",
          height: size.height * 0.025,
          color: Colors.black,
        ),
        SizedBox(width: size.width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        )
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/constant/assets.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_detail_box.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
// import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

// class AccountListProfileWidget extends StatefulWidget {
//   final ValueNotifier<CustomerDetailModel?> customerDetail;
//   const AccountListProfileWidget({Key? key, required this.customerDetail})
//       : super(key: key);

//   @override
//   State<AccountListProfileWidget> createState() =>
//       _AccountListProfileWidgetState();
// }

// class _AccountListProfileWidgetState extends State<AccountListProfileWidget> {
//   bool showPersonalDetail = false;
//   bool _isExpanded = false;

//   void _handleShare() {
//     // Implement your share functionality here
//     print('Share button pressed');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     bool showPrimaryAccount = false;
//     filterLoanType(CustomerDetailModel? customerDetail) {
//       final List showValidAccount = customerDetail!.accountDetail
//           .where((element) =>
//               element.accountType.toLowerCase() == "loan" ||
//               element.accountType.toLowerCase() == "od")
//           .toList();
//       return showValidAccount;
//     }

//     // List filterLoanType(CustomerDetailModel? customerDetail) {
//     //   if (customerDetail == null) return [];
//     //   return customerDetail.accountDetail;
//     // }
//     // Set<int> expandedIndices = {};
//     filterOtherType(CustomerDetailModel? customerDetail) {
//       final List showValidAccount = customerDetail!.accountDetail
//           .where((element) =>
//               element.accountType.toLowerCase() != "loan" &&
//               element.accountType.toLowerCase() != "od")
//           .toList();
//       return showValidAccount;
//     }
//     // List filterOtherType(CustomerDetailModel? customerDetail) {
//     //   if (customerDetail == null) return [];
//     //   return customerDetail.accountDetail;
//     // }

//     return PageWrapper(
//       padding: EdgeInsets.zero,
//       showAppBar: false,
//       body: ListView(
//         children: [
//           ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: filterOtherType(widget.customerDetail.value).length,
//               itemBuilder: (context, index) {
//                 final _detail = filterOtherType(widget.customerDetail.value);
//                 final accuredInterest =
//                     _detail[index].accruedInterest.toString().toLowerCase();
//                 final interestRate =
//                     _detail[index].interestRate.toString().toLowerCase();
//                 // final _isExpanded = expandedIndices.contains(index);
//                 return Container(
//                   color: Colors.white,
//                   child: Column(
//                     children: [
//                       ExpansionTile(
//                         onExpansionChanged: (expanded) {
//                           setState(() {
//                             _isExpanded = expanded;
//                           });
//                         },
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.share),
//                               onPressed: _handleShare,
//                               splashRadius: 20,
//                             ),
//                             AnimatedRotation(
//                               turns: _isExpanded ? 0.5 : 0,
//                               duration: const Duration(milliseconds: 300),
//                               child: const Icon(Icons.expand_more),
//                             ),
//                           ],
//                         ),
//                         title: CommonDetailBox(
//                             showTrailingIcon: false,
//                             leadingImage: Assets.profileIcon,
//                             title: (_detail[index]
//                                         .accountTypeDescription
//                                         ?.isNotEmpty ??
//                                     false)
//                                 ? _detail[index].accountTypeDescription
//                                 : _detail[index].accountType,
//                             detail: "A/C : ${_detail[index].mainCode}",
//                             onBoxPressed: () {
//                               setState(() {
//                                 showPrimaryAccount = !showPrimaryAccount;
//                               });
//                               print(showPrimaryAccount);
//                             }),
//                         children: [
//                           Container(
//                             //lists of each saving
//                             color: _theme.scaffoldBackgroundColor,
//                             height: _height * 0.19,
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 // Row(
//                                 //   children: [
//                                 //     Expanded(
//                                 //       child: buildDetails(
//                                 //         context,
//                                 //         "Banking.svg",
//                                 //         "Account Type",
//                                 //         _detail[index].accountTypeDescription ??
//                                 //             _detail[index].accountType + " A/C",
//                                 //       ),
//                                 //     ),
//                                 //     SizedBox(
//                                 //       width: _width * 0.4,
//                                 //       child: buildDetails(
//                                 //           context,
//                                 //           "clientcode.svg",
//                                 //           "Member ID",
//                                 //           "${_detail[index].clientCode}"),
//                                 //     )
//                                 //   ],
//                                 // ),
//                                 Row(
//                                   children: [
//                                     if (_detail[index]
//                                                 .actualBalance
//                                                 .toString()
//                                                 .toLowerCase() !=
//                                             "n/a" ||
//                                         _detail[index]
//                                                 .actualBalance
//                                                 .toString()
//                                                 .toLowerCase() !=
//                                             "null")
//                                       Expanded(
//                                         child: buildDetails(
//                                             context,
//                                             "actual balance profile page.svg",
//                                             "Actual Balance",
//                                             "NPR ${_detail[index].actualBalance}"),
//                                       ),
//                                     if (_detail[index]
//                                                 .availableBalance
//                                                 .toString()
//                                                 .toLowerCase() !=
//                                             "N/A".toLowerCase() ||
//                                         _detail[index]
//                                                 .availableBalance
//                                                 .toString()
//                                                 .toLowerCase() !=
//                                             "null")
//                                       SizedBox(
//                                         width: _width * 0.4,
//                                         child: buildDetails(
//                                             context,
//                                             "money-send-svgrepo-com 1.svg",
//                                             "Available Bal.",
//                                             "NPR ${_detail[index].availableBalance}"),
//                                       ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     if (accuredInterest != "0.0" &&
//                                         accuredInterest != "0" &&
//                                         accuredInterest != "null" &&
//                                         accuredInterest != "n/a" &&
//                                         accuredInterest != "N/A" &&
//                                         accuredInterest != "")
//                                       Expanded(
//                                         child: buildDetails(
//                                             context,
//                                             "accrued interest.svg",
//                                             "Accrued Interest",
//                                             "NPR ${_detail[index].accruedInterest}"),
//                                       ),
//                                     if (interestRate != "0" &&
//                                         interestRate != "0.0" &&
//                                         interestRate != "null" &&
//                                         interestRate != "n/a" &&
//                                         interestRate != "N/A" &&
//                                         interestRate != "")
//                                       SizedBox(
//                                         width: _width * 0.4,
//                                         child: buildDetails(
//                                             context,
//                                             "interest rate profile.svg",
//                                             "Interest Rate",
//                                             "${_detail[index].interestRate} %"),
//                                       ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: filterLoanType(widget.customerDetail.value).length,
//             itemBuilder: (context, index) {
//               final loanAccountNumber =
//                   filterLoanType(widget.customerDetail.value);
//               return BlocProvider(
//                 create: (context) => UtilityPaymentCubit(
//                     utilityPaymentRepository:
//                         RepositoryProvider.of<UtilityPaymentRepository>(
//                             context))
//                   ..fetchDetails(
//                       serviceIdentifier: "",
//                       accountDetails: {
//                         "accountNumber": loanAccountNumber[index].accountNumber,
//                       },
//                       shouldIncludeMPIN: true,
//                       apiEndpoint: "/api/loan/details"),
//                 child: BlocBuilder<UtilityPaymentCubit, CommonState>(
//                   builder: (context, state) {
//                     final _detail = filterLoanType(widget.customerDetail.value);
//                     if (state is CommonStateSuccess) {
//                       final UtilityResponseData res = state.data;
//                       if (res.code == "M0000") {
//                         return Container(
//                           color: Colors.white,
//                           child: Column(
//                             children: [
//                               ExpansionTile(
//                                 onExpansionChanged: (expanded) {
//                                   setState(() {
//                                     _isExpanded = expanded;
//                                   });
//                                 },
//                                 trailing: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(Icons.share),
//                                       onPressed: _handleShare,
//                                       splashRadius: 20,
//                                     ),
//                                     AnimatedRotation(
//                                       turns: _isExpanded ? 0.5 : 0,
//                                       duration:
//                                           const Duration(milliseconds: 300),
//                                       child: const Icon(Icons.expand_more),
//                                     ),
//                                   ],
//                                 ),
//                                 title: CommonDetailBox(
//                                     showTrailingIcon: false,
//                                     leadingImage: Assets.profileIcon,
//                                     title: _detail[index]
//                                             .accountTypeDescription
//                                             .toString()
//                                             .isNotEmpty
//                                         ? _detail[index].accountTypeDescription
//                                         : _detail[index].accountType,
//                                     detail: "A/C : ${_detail[index].mainCode}",
//                                     onBoxPressed: () {
//                                       setState(() {
//                                         showPrimaryAccount =
//                                             !showPrimaryAccount;
//                                       });
//                                       print(showPrimaryAccount);
//                                     }),
//                                 children: [
//                                   Container(
//                                     color: _theme.scaffoldBackgroundColor,
//                                     height: _height * 0.19,
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 12),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: buildDetails(
//                                                   context,
//                                                   "money-send-svgrepo-com 1.svg",
//                                                   "Balance",
//                                                   res.findValueString(
//                                                       "balance")),
//                                             ),
//                                             SizedBox(
//                                               width: _width * 0.4,
//                                               child: buildDetails(
//                                                 context,
//                                                 "actual balance profile page.svg",
//                                                 "Disbursed Amt",
//                                                 res.findValueString(
//                                                     "disbursedAmount"),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: buildDetails(
//                                                   context,
//                                                   "accrued interest.svg",
//                                                   "Interest Rate",
//                                                   "${res.findValueString("interestRate")}"),
//                                             ),
//                                             SizedBox(
//                                               width: _width * 0.4,
//                                               child: buildDetails(
//                                                   context,
//                                                   "uit_calender.svg",
//                                                   "Duration",
//                                                   "${res.findValueString("duration")} "),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         return Container();
//                       }
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 10.hp),
//         ],
//       ),
//     );
//   }

//   // final List accountType = ["Primary Account", "Secondary Account"];

//   buildDetails(BuildContext context, images, title, value) {
//     final Size size = MediaQuery.of(context).size;
//     return Row(
//       children: [
//         SvgPicture.asset(
//           "assets/icons/$images",
//           height: size.height * 0.025,
//           color: Colors.black,
//         ),
//         SizedBox(width: size.width * 0.03),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: Theme.of(context).textTheme.titleSmall,
//             ),
//             Text(
//               value,
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
