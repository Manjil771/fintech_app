// // import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/common_loading_widget.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/common/widget/show_loading_dialog.dart';
// import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// import 'package:ismart/feature/qrCode/shareQr/widget/external_qr_widget.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
// import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';
// // import 'package:screen_brightness/screen_brightness.dart';

// class ShareQrWidget extends StatefulWidget {
//   const ShareQrWidget({super.key});

//   @override
//   State<ShareQrWidget> createState() => _ShareQrWidgetState();
// }

// class _ShareQrWidgetState extends State<ShareQrWidget> {
//   // final ScreenBrightness _screenBrightness = ScreenBrightness.instance;
//   // double? _previousBrightnessLevel;
//   // StreamSubscription? _brightnessSubscription;
//   // bool _brightnessPermissionGranted = false;

//   @override
//   void initState() {
//     super.initState();
//     // _setupScreenBrightness();
//   }

//   // Future<void> _setupScreenBrightness() async {
//   //   try {
//   //     _previousBrightnessLevel = await _screenBrightness.system;
//   //     await _screenBrightness.setSystemScreenBrightness(0.9);
//   //     _brightnessPermissionGranted = true;
//   //     _brightnessSubscription = _screenBrightness
//   //         .onSystemScreenBrightnessChanged
//   //         .listen((brightness) {});
//   //   } catch (e) {
//   //     print('Unexpected error in brightness setup: $e');
//   //     _brightnessPermissionGranted = false;
//   //   }
//   // }

//   @override
//   dispose() {
//     // _restoreScreenBrightness();
//     // _brightnessSubscription?.cancel();
//     super.dispose();
//   }

//   // Future<void> _restoreScreenBrightness() async {
//   //   try {
//   //     if (_brightnessPermissionGranted && _previousBrightnessLevel != null) {
//   //       await _screenBrightness
//   //           .setSystemScreenBrightness(_previousBrightnessLevel!);
//   //     }
//   //   } catch (e) {
//   //     print('Unexpected error restoring screen brightness: $e');
//   //   }
//   // }

//   bool isInternalQr = false;

//   bool _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _height = SizeUtils.height;
//     return PageWrapper(
//       body: CommonContainer(
//         verticalPadding: 0,
//         showDetail: false,
//         showRoundBotton: false,
//         showTitleText: false,
//         topbarName: "My QR",
//         body: BlocConsumer<UtilityPaymentCubit, CommonState>(
//           listener: (context, state) {
//             if (state is CommonLoading && !_isLoading) {
//               _isLoading = true;
//               showLoadingDialogBox(context);
//             } else if (state is! CommonLoading && _isLoading) {
//               _isLoading = false;
//               NavigationService.pop();
//             }

//             if (state is CommonError) {
//               showPopUpDialog(
//                 context: context,
//                 message: state.message,
//                 title: "Error",
//                 showCancelButton: false,
//                 buttonCallback: () {
//                   NavigationService.pop();
//                 },
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is CommonStateSuccess<UtilityResponseData>) {
//               List qrData = state.data.findValue(primaryKey: "data");
//               qrData = qrData.reversed.toList();

//               return Container(
//                   height: _height,
//                   child: DefaultTabController(
//                     initialIndex: 0,
//                     length: 2,
//                     child: Column(
//                       children: [
//                         TabBar(
//                           labelColor: Colors.black,
//                           unselectedLabelColor: const Color(0xFF989898),
//                           labelStyle: const TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                           indicatorColor: _theme.primaryColor,
//                           automaticIndicatorColorAdjustment: true,
//                           tabs: List.generate(
//                             qrData.length,
//                             (index) => Tab(text: qrData[index]["name"]),
//                           ),
//                         ),
//                         SizedBox(height: _height * 0.02),
//                         Expanded(
//                           child: TabBarView(
//                             children: List.generate(
//                               qrData.length,
//                               (index) => BlocProvider(
//                                 create: (context) => UtilityPaymentCubit(
//                                     utilityPaymentRepository: RepositoryProvider
//                                         .of<UtilityPaymentRepository>(context)),
//                                 child: ExternalQrWidget(
//                                   showQr: qrData[index]["qrLogoPath"]
//                                                   .toString()
//                                                   .toLowerCase() !=
//                                               "null" ||
//                                           qrData[index]["qrLogoPath"]
//                                               .toString()
//                                               .isNotEmpty
//                                       ? true
//                                       : false,
//                                   qrDetail: qrData[index],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ));
//             } else if (state is CommonLoading) {
//               return const Center(child: CommonLoadingWidget());
//             } else {
//               return Container(
//                 child: Text(state.toString()),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:ismart/common/common/data_state.dart';
// // import 'package:ismart/common/navigation/navigation_service.dart';
// // import 'package:ismart/common/util/size_utils.dart';
// // import 'package:ismart/common/widget/common_container.dart';
// // import 'package:ismart/common/widget/page_wrapper.dart';
// // import 'package:ismart/common/widget/show_loading_dialog.dart';
// // import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// // import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// // import 'package:ismart/feature/qrCode/shareQr/resources/qr_cubit.dart';
// // import 'package:ismart/feature/qrCode/shareQr/widget/external_qr_widget.dart';
// // import 'package:ismart/feature/qrCode/shareQr/widget/internal_qr_widget.dart';

// // class ShareQrWidget extends StatefulWidget {
// //   const ShareQrWidget({super.key});

// //   @override
// //   State<ShareQrWidget> createState() => _ShareQrWidgetState();
// // }

// // class _ShareQrWidgetState extends State<ShareQrWidget> {
// //   final detail =
// //       RepositoryProvider.of<CustomerDetailRepository>(NavigationService.context)
// //           .selectedAccount
// //           .value!;
// //   @override
// //   void initState() {
// //     context.read<QrCubit>().generateQr(
// //         customerName: detail.accountHolderName, customerId: detail.id);
// //     super.initState();
// //   }

// //   bool isInternalQr = false;

// //   bool _isLoading = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     final _theme = Theme.of(context);
// //     final _textTheme = _theme.textTheme;
// //     final _height = SizeUtils.height;
// //     final _width = SizeUtils.width;
// //     final userDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
// //         .selectedAccount
// //         .value!;
// //     return PageWrapper(
// //       body: CommonContainer(
// //         verticalPadding: 0,
// //         showDetail: false,
// //         showRoundBotton: false,
// //         showTitleText: false,
// //         topbarName: "My QR",
// //         body: BlocConsumer<QrCubit, CommonState>(
// //           listener: (context, state) {
// //             if (state is CommonLoading && !_isLoading) {
// //               _isLoading = true;
// //               showLoadingDialogBox(context);
// //             } else if (state is! CommonLoading && _isLoading) {
// //               _isLoading = false;
// //               NavigationService.pop();
// //             }

// //             if (state is CommonError) {
// //               showPopUpDialog(
// //                 context: context,
// //                 message: state.message,
// //                 title: "Error",
// //                 showCancelButton: false,
// //                 buttonCallback: () {
// //                   NavigationService.pop();
// //                 },
// //               );
// //             }
// //           },
// //           builder: (context, state) {
// //             if (state is CommonStateSuccess) {
// //               return Container(
// //                 height: _height,
// //                 child: (state.data["data"]?["details"]?["ExternalQRURL"] ?? "")
// //                         .toString()
// //                         .isNotEmpty
// //                     ? DefaultTabController(
// //                         initialIndex: 0,
// //                         length: 2,
// //                         child: Column(
// //                           children: [
// //                             TabBar(
// //                               labelColor: Colors.black,
// //                               unselectedLabelColor: const Color(0xFF989898),
// //                               labelStyle: const TextStyle(
// //                                   fontSize: 16, fontWeight: FontWeight.w500),
// //                               indicatorColor: _theme.primaryColor,
// //                               automaticIndicatorColorAdjustment: true,
// //                               tabs: const [
// //                                 Tab(text: "FonePay QR"),
// //                                 Tab(text: "Internal QR"),
// //                               ],
// //                             ),
// //                             SizedBox(height: _height * 0.02),
// //                             Expanded(
// //                               child: TabBarView(
// //                                 children: [
// //                                   // Column(
// //                                   //   children: [
// //                                   //     const NoDataScreen(
// //                                   //       title: "No FonePay QR found.",
// //                                   //       details: "",
// //                                   //     ),
// //                                   //     // const SizedBox(height: 10),
// //                                   //     CustomRoundedButtom(
// //                                   //         title: "Request for QR",
// //                                   //         onPressed: () {})
// //                                   //   ],
// //                                   // ),
// //                                   ExternalQrWidget(
// //                                       qrPath: state.data["data"]["details"]
// //                                               ["ExternalQRURL"]
// //                                           .toString()),
// //                                   InternalQrWidget(
// //                                       qrPath: state.data["data"]["details"]
// //                                               ["QRCodePath"]
// //                                           .toString()),
// //                                 ],
// //                               ),
// //                             )
// //                           ],
// //                         ),
// //                       )
// //                     : InternalQrWidget(
// //                         qrPath: state.data["data"]["details"]["QRCodePath"]
// //                             .toString()),
// //               );
// //             } else {
// //               return Container();
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/qrCode/shareQr/widget/external_qr_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';
// import 'package:screen_brightness/screen_brightness.dart';

class ShareQrWidget extends StatefulWidget {
  const ShareQrWidget({super.key});

  @override
  State<ShareQrWidget> createState() => _ShareQrWidgetState();
}

class _ShareQrWidgetState extends State<ShareQrWidget> {
  // final ScreenBrightness _screenBrightness = ScreenBrightness.instance;
  // double? _previousBrightnessLevel;
  // StreamSubscription? _brightnessSubscription;
  // bool _brightnessPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    // _setupScreenBrightness();
  }

  // Future<void> _setupScreenBrightness() async {
  //   try {
  //     _previousBrightnessLevel = await _screenBrightness.system;
  //     await _screenBrightness.setSystemScreenBrightness(0.9);
  //     _brightnessPermissionGranted = true;
  //     _brightnessSubscription = _screenBrightness
  //         .onSystemScreenBrightnessChanged
  //         .listen((brightness) {});
  //   } catch (e) {
  //     print('Unexpected error in brightness setup: $e');
  //     _brightnessPermissionGranted = false;
  //   }
  // }

  @override
  dispose() {
    // _restoreScreenBrightness();
    // _brightnessSubscription?.cancel();
    super.dispose();
  }

  // Future<void> _restoreScreenBrightness() async {
  //   try {
  //     if (_brightnessPermissionGranted && _previousBrightnessLevel != null) {
  //       await _screenBrightness
  //           .setSystemScreenBrightness(_previousBrightnessLevel!);
  //     }
  //   } catch (e) {
  //     print('Unexpected error restoring screen brightness: $e');
  //   }
  // }

  bool isInternalQr = false;

  bool _isLoading = false;

  // Helper method to check if imagePath is valid
  bool _hasValidImagePath(dynamic item) {
    final imagePath = item["imagePath"];
    return imagePath != null &&
        imagePath.toString().isNotEmpty &&
        imagePath.toString().toLowerCase() != "null";
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 0,
        showDetail: false,
        showRoundBotton: false,
        showTitleText: false,
        topbarName: "My QR",
        body: BlocConsumer<UtilityPaymentCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoading && !_isLoading) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            }

            if (state is CommonError) {
              showPopUpDialog(
                context: context,
                message: state.message,
                title: "Error",
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          },
          builder: (context, state) {
            if (state is CommonStateSuccess<UtilityResponseData>) {
              List qrData = state.data.findValue(primaryKey: "data");
              qrData = qrData.reversed.toList();

              // Filter out items with empty or null imagePath
              List filteredQrData =
                  qrData.where((item) => _hasValidImagePath(item)).toList();

              // If no valid items, show a message
              if (filteredQrData.isEmpty) {
                return const Center(
                  child: Text(
                    "No QR codes available",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return Container(
                  height: _height,
                  child: DefaultTabController(
                    initialIndex: 0,
                    length: filteredQrData.length,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: const Color(0xFF989898),
                          labelStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          indicatorColor: _theme.primaryColor,
                          automaticIndicatorColorAdjustment: true,
                          tabs: List.generate(
                            filteredQrData.length,
                            (index) => Tab(text: filteredQrData[index]["name"]),
                          ),
                        ),
                        SizedBox(height: _height * 0.02),
                        Expanded(
                          child: TabBarView(
                            children: List.generate(
                              filteredQrData.length,
                              (index) => BlocProvider(
                                create: (context) => UtilityPaymentCubit(
                                    utilityPaymentRepository: RepositoryProvider
                                        .of<UtilityPaymentRepository>(context)),
                                child: ExternalQrWidget(
                                  showQr: filteredQrData[index]["qrLogoPath"]
                                                  .toString()
                                                  .toLowerCase() !=
                                              "null" ||
                                          filteredQrData[index]["qrLogoPath"]
                                              .toString()
                                              .isNotEmpty
                                      ? true
                                      : false,
                                  qrDetail: filteredQrData[index],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
            } else if (state is CommonLoading) {
              return const Center(child: CommonLoadingWidget());
            } else {
              return Container(
                child: Text(state.toString()),
              );
            }
          },
        ),
      ),
    );
  }
}
