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
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/qrCode/shareQr/widget/external_qr_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ShareQrWidget extends StatefulWidget {
  const ShareQrWidget({super.key});

  @override
  State<ShareQrWidget> createState() => _ShareQrWidgetState();
}

class _ShareQrWidgetState extends State<ShareQrWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool isInternalQr = false;

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;
    final userDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .selectedAccount
        .value!;
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
              return Container(
                  height: _height,
                  child: DefaultTabController(
                    initialIndex: 0,
                    length: 2,
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
                            qrData.length,
                            (index) => Tab(text: qrData[index]["name"]),
                          ),
                        ),
                        SizedBox(height: _height * 0.02),
                        Expanded(
                          child: TabBarView(
                            children: List.generate(
                              qrData.length,
                              (index) => ExternalQrWidget(
                                qrDetail: qrData[index],
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
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/common/widget/show_loading_dialog.dart';
// import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// import 'package:ismart/feature/qrCode/shareQr/resources/qr_cubit.dart';
// import 'package:ismart/feature/qrCode/shareQr/widget/external_qr_widget.dart';
// import 'package:ismart/feature/qrCode/shareQr/widget/internal_qr_widget.dart';

// class ShareQrWidget extends StatefulWidget {
//   const ShareQrWidget({super.key});

//   @override
//   State<ShareQrWidget> createState() => _ShareQrWidgetState();
// }

// class _ShareQrWidgetState extends State<ShareQrWidget> {
//   final detail =
//       RepositoryProvider.of<CustomerDetailRepository>(NavigationService.context)
//           .selectedAccount
//           .value!;
//   @override
//   void initState() {
//     context.read<QrCubit>().generateQr(
//         customerName: detail.accountHolderName, customerId: detail.id);
//     super.initState();
//   }

//   bool isInternalQr = false;

//   bool _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _height = SizeUtils.height;
//     final _width = SizeUtils.width;
//     final userDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
//         .selectedAccount
//         .value!;
//     return PageWrapper(
//       body: CommonContainer(
//         verticalPadding: 0,
//         showDetail: false,
//         showRoundBotton: false,
//         showTitleText: false,
//         topbarName: "My QR",
//         body: BlocConsumer<QrCubit, CommonState>(
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
//             if (state is CommonStateSuccess) {
//               return Container(
//                 height: _height,
//                 child: (state.data["data"]?["details"]?["ExternalQRURL"] ?? "")
//                         .toString()
//                         .isNotEmpty
//                     ? DefaultTabController(
//                         initialIndex: 0,
//                         length: 2,
//                         child: Column(
//                           children: [
//                             TabBar(
//                               labelColor: Colors.black,
//                               unselectedLabelColor: const Color(0xFF989898),
//                               labelStyle: const TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w500),
//                               indicatorColor: _theme.primaryColor,
//                               automaticIndicatorColorAdjustment: true,
//                               tabs: const [
//                                 Tab(text: "FonePay QR"),
//                                 Tab(text: "Internal QR"),
//                               ],
//                             ),
//                             SizedBox(height: _height * 0.02),
//                             Expanded(
//                               child: TabBarView(
//                                 children: [
//                                   // Column(
//                                   //   children: [
//                                   //     const NoDataScreen(
//                                   //       title: "No FonePay QR found.",
//                                   //       details: "",
//                                   //     ),
//                                   //     // const SizedBox(height: 10),
//                                   //     CustomRoundedButtom(
//                                   //         title: "Request for QR",
//                                   //         onPressed: () {})
//                                   //   ],
//                                   // ),
//                                   ExternalQrWidget(
//                                       qrPath: state.data["data"]["details"]
//                                               ["ExternalQRURL"]
//                                           .toString()),
//                                   InternalQrWidget(
//                                       qrPath: state.data["data"]["details"]
//                                               ["QRCodePath"]
//                                           .toString()),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       )
//                     : InternalQrWidget(
//                         qrPath: state.data["data"]["details"]["QRCodePath"]
//                             .toString()),
//               );
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }