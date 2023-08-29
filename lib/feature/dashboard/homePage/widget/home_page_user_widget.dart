// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ismart/app/theme.dart';
// import 'package:ismart/common/constant/assets.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/account_list_box.dart';
// import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
// import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// import 'package:ismart/feature/qrscanner/screens/qrscanner_screen.dart';

// class HomePageUserWidget extends StatefulWidget {
//   const HomePageUserWidget({Key? key}) : super(key: key);

//   @override
//   State<HomePageUserWidget> createState() => _HomePageUserWidgetState();
// }

// class _HomePageUserWidgetState extends State<HomePageUserWidget> {
//   bool showAmountDetail = false;
//   ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);
//   ValueNotifier<AccountDetail?> selectedAccountNotifier = ValueNotifier(null);
//   ValueNotifier<dynamic> accountDetail = ValueNotifier([]);
//   String formattedDate = DateFormat('a').format(DateTime.now());

//   String bannerImage = "";
//   @override
//   void initState() {
//     customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
//         .customerDetailModel;
//     accountDetail =
//         RepositoryProvider.of<CustomerDetailRepository>(context).accountsList;
//     selectedAccountNotifier =
//         RepositoryProvider.of<CustomerDetailRepository>(context)
//             .selectedAccount;

//     bannerImage = RepositoryProvider.of<CoOperative>(context).bannerImage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: _theme.scaffoldBackgroundColor,
//           image: DecorationImage(
//             image: AssetImage(
//               RepositoryProvider.of<CoOperative>(context)
//                   .backgroundImage
//                   .toString(),
//             ),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: ValueListenableBuilder<AccountDetail?>(
//             valueListenable: selectedAccountNotifier,
//             builder: (context, selectedAcc, _) {
//               return ValueListenableBuilder<CustomerDetailModel?>(
//                   valueListenable: customerDetail,
//                   builder: (context, val, _) {
//                     if (val != null) {
//                       return Column(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 12),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           formattedDate == 'AM'
//                                               ? 'Good Morning,'
//                                               : 'Good Afternoon,',
//                                           style: _textTheme.headlineMedium
//                                               ?.copyWith(
//                                             color: CustomTheme.white,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Text(
//                                           val.fullName,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: _textTheme.headlineMedium
//                                               ?.copyWith(
//                                             color: CustomTheme.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Expanded(
//                                       child: InkWell(
//                                         onTap: () {
//                                           NavigationService.push(
//                                               target: QRScannerScreens());
//                                         },
//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding:
//                                                 EdgeInsets.only(right: 4.hp),
//                                             child: SvgPicture.asset(
//                                               Assets.qrCodeIcon,
//                                               height: 30.hp,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 // const Spacer(),
//                                 Row(
//                                   children: [
//                                     InkWell(
//                                       onTap: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) =>
//                                               const AccountDetailBox(),
//                                         );
//                                       },
//                                       child: Row(
//                                         children: [
//                                           Container(
//                                             width: _width * 0.4,
//                                             child: Text(
//                                               "${selectedAcc?.accountType} A/C :\n${selectedAcc?.mainCode}",
//                                               style: _textTheme.titleSmall
//                                                   ?.copyWith(
//                                                 color: CustomTheme.white,
//                                                 fontSize: 11,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(width: _width * 0.02),
//                                           RotatedBox(
//                                             quarterTurns: 5,
//                                             child: SvgPicture.asset(
//                                               Assets.arrowRight,
//                                               color: CustomTheme.white,
//                                               height: _height * 0.015,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Text(
//                                           "Interest Rate: ${selectedAcc?.interestRate} %",
//                                           style:
//                                               _textTheme.titleSmall?.copyWith(
//                                             color: CustomTheme.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 20.hp),
//                                 InkWell(
//                                   onTap: () {
//                                     setState(() {
//                                       showAmountDetail = !showAmountDetail;
//                                     });
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Actual Balance",
//                                             style: _textTheme.titleSmall!
//                                                 .copyWith(
//                                                     color: CustomTheme.white),
//                                           ),
//                                           Text(
//                                             showAmountDetail
//                                                 ? "NPR ${selectedAcc?.actualBalance}"
//                                                 : "XXXXXXXXX",
//                                             style: _textTheme.titleLarge!
//                                                 .copyWith(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: CustomTheme.white),
//                                           ),
//                                         ],
//                                       ),
//                                       InkWell(
//                                         // onTap: () {
//                                         //   setState(() {
//                                         //     showAmountDetail = !showAmountDetail;
//                                         //   });
//                                         // },
//                                         child: Icon(
//                                           showAmountDetail
//                                               ? Icons.visibility
//                                               : Icons.visibility_off,
//                                           color: CustomTheme.white,
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             "Available Balance",
//                                             style: _textTheme.titleSmall!
//                                                 .copyWith(
//                                                     color: CustomTheme.white),
//                                           ),
//                                           Text(
//                                             showAmountDetail
//                                                 ? "NPR ${selectedAcc?.availableBalance}"
//                                                 : "XXXXXXXXX",
//                                             style: _textTheme.titleLarge!
//                                                 .copyWith(
//                                                     fontWeight: FontWeight.bold,
//                                                     color: CustomTheme.white),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // Padding(
//                           //   padding: const EdgeInsets.symmetric(
//                           //     // vertical: 12,
//                           //     horizontal: 12,
//                           //   ),
//                           //   child: InkWell(
//                           //     onTap: () {
//                           //       setState(() {
//                           //         showAmountDetail = !showAmountDetail;
//                           //       });
//                           //     },
//                           //     child: Row(
//                           //       mainAxisAlignment:
//                           //           MainAxisAlignment.spaceBetween,
//                           //       children: [
//                           //         Column(
//                           //           crossAxisAlignment:
//                           //               CrossAxisAlignment.start,
//                           //           children: [
//                           //             Text(
//                           //               "Actual Balance",
//                           //               style: _textTheme.titleSmall!
//                           //                   .copyWith(color: CustomTheme.white),
//                           //             ),
//                           //             Text(
//                           //               showAmountDetail
//                           //                   ? "NPR ${selectedAcc?.actualBalance}"
//                           //                   : "XXXXXXXXX",
//                           //               style: _textTheme.titleLarge!.copyWith(
//                           //                   fontWeight: FontWeight.bold,
//                           //                   color: CustomTheme.white),
//                           //             ),
//                           //           ],
//                           //         ),
//                           //         InkWell(
//                           //           // onTap: () {
//                           //           //   setState(() {
//                           //           //     showAmountDetail = !showAmountDetail;
//                           //           //   });
//                           //           // },
//                           //           child: Icon(
//                           //             showAmountDetail
//                           //                 ? Icons.visibility
//                           //                 : Icons.visibility_off,
//                           //             color: CustomTheme.white,
//                           //           ),
//                           //         ),
//                           //         Column(
//                           //           crossAxisAlignment:
//                           //               CrossAxisAlignment.start,
//                           //           children: [
//                           //             Text(
//                           //               "Available Balance",
//                           //               style: _textTheme.titleSmall!
//                           //                   .copyWith(color: CustomTheme.white),
//                           //             ),
//                           //             Text(
//                           //               showAmountDetail
//                           //                   ? "NPR ${selectedAcc?.availableBalance}"
//                           //                   : "XXXXXXXXX",
//                           //               style: _textTheme.titleLarge!.copyWith(
//                           //                   fontWeight: FontWeight.bold,
//                           //                   color: CustomTheme.white),
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       ],
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       );
//                     } else {
//                       return Container();
//                     }
//                   });
//             }));
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/account_list_box.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/qrscanner/screens/qrscanner_screen.dart';

class HomePageUserWidget extends StatefulWidget {
  const HomePageUserWidget({Key? key}) : super(key: key);

  @override
  State<HomePageUserWidget> createState() => _HomePageUserWidgetState();
}

class _HomePageUserWidgetState extends State<HomePageUserWidget> {
  bool showAmountDetail = false;
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);
  ValueNotifier<AccountDetail?> selectedAccountNotifier = ValueNotifier(null);
  ValueNotifier<dynamic> accountDetail = ValueNotifier([]);
  String formattedDate = DateFormat('a').format(DateTime.now());

  String bannerImage = "";
  @override
  void initState() {
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
    accountDetail =
        RepositoryProvider.of<CustomerDetailRepository>(context).accountsList;
    selectedAccountNotifier =
        RepositoryProvider.of<CustomerDetailRepository>(context)
            .selectedAccount;

    bannerImage = RepositoryProvider.of<CoOperative>(context).bannerImage;
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: CustomTheme.white),
        child: ValueListenableBuilder<AccountDetail?>(
            valueListenable: selectedAccountNotifier,
            builder: (context, selectedAcc, _) {
              return ValueListenableBuilder<CustomerDetailModel?>(
                  valueListenable: customerDetail,
                  builder: (context, val, _) {
                    if (val != null) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            height: _height * 0.16,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    RepositoryProvider.of<CoOperative>(context)
                                        .backgroundImage
                                        .toString()),
                                fit: BoxFit.fitWidth,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formattedDate == 'AM'
                                              ? 'Good Morning,'
                                              : 'Good Afternoon,',
                                          style: _textTheme.headlineMedium
                                              ?.copyWith(
                                            color: CustomTheme.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          val.fullName,
                                          overflow: TextOverflow.ellipsis,
                                          style: _textTheme.headlineMedium
                                              ?.copyWith(
                                            color: CustomTheme.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          NavigationService.push(
                                              target: QRScannerScreens());
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.hp),
                                            child: SvgPicture.asset(
                                              Assets.qrCodeIcon,
                                              height: 30.hp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // const Spacer(),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const AccountDetailBox(),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: _width * 0.4,
                                            child: Text(
                                              "${selectedAcc?.accountType} A/C :\n${selectedAcc?.mainCode}",
                                              style: _textTheme.titleSmall
                                                  ?.copyWith(
                                                color: CustomTheme.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: _width * 0.02),
                                          RotatedBox(
                                            quarterTurns: 5,
                                            child: SvgPicture.asset(
                                              Assets.arrowRight,
                                              color: CustomTheme.white,
                                              height: _height * 0.015,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Interest Rate: ${selectedAcc?.interestRate} %",
                                          style:
                                              _textTheme.titleSmall?.copyWith(
                                            color: CustomTheme.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  showAmountDetail = !showAmountDetail;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Actual Balance",
                                        style: _textTheme.titleSmall,
                                      ),
                                      Text(
                                        showAmountDetail
                                            ? "NPR ${selectedAcc?.actualBalance}"
                                            : "XXXXXXXXX",
                                        style: _textTheme.titleLarge!.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    // onTap: () {
                                    //   setState(() {
                                    //     showAmountDetail = !showAmountDetail;
                                    //   });
                                    // },
                                    child: Icon(
                                      showAmountDetail
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Available Balance",
                                        style: _textTheme.titleSmall,
                                      ),
                                      Text(
                                        showAmountDetail
                                            ? "NPR ${selectedAcc?.availableBalance}"
                                            : "XXXXXXXXX",
                                        style: _textTheme.titleLarge!.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  });
            }));
  }
}
