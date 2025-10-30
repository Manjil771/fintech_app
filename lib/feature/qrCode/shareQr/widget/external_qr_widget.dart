import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class ExternalQrWidget extends StatelessWidget {
  final Map<String, dynamic> qrDetail;
  final bool showQr;

  ExternalQrWidget({super.key, required this.qrDetail, required this.showQr});
  final _screenShotController = ScreenshotController();
  XFile? imageFile;

  final detail =
      RepositoryProvider.of<CustomerDetailRepository>(NavigationService.context)
          .selectedAccount
          .value!;
  final repo = RepositoryProvider.of<CoOperative>(NavigationService.context);
  takeScreenshot() async {
    final image = await _screenShotController.capture();
    // ignore: unused_local_variable
    final tempFile = await _createTempImageFile(image!);

    if (tempFile != null) {
      Share.shareXFiles([XFile(tempFile.path)]);
    }
  }

  Future<XFile?> _createTempImageFile(Uint8List image) async {
    try {
      final directory = await getTemporaryDirectory();
      const tempFileName = 'screenshot.png';
      final tempFilePath = '${directory.path}/$tempFileName';
      await File(tempFilePath).writeAsBytes(image);
      return XFile(tempFilePath);
    } catch (e) {
      print('Error creating temp image file: $e');
      return null;
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final List newData = qrData
    //     .where(
    //       (element) =>
    //           element["imagePath"].toString().isNotEmpty &&
    //           element["imagePath"].toString().toLowerCase() != "null",
    //     )
    //     .toList();
    return BlocListener<UtilityPaymentCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoading && _isLoading == false) {
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
        if (state is CommonStateSuccess<UtilityResponseData>) {
          final UtilityResponseData _response = state.data;
          if (_response.code == "M0000") {
            showPopUpDialog(
              context: context,
              message: _response.message,
              title: "Success",
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          } else {
            showPopUpDialog(
              context: context,
              message: _response.message,
              title: "Exception",
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }
        }
      },
      child: Column(
        children: [
          Screenshot(
            controller: _screenShotController,
            child: Container(
              margin: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: CustomTheme.darkerBlack)),
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  qrDetail["qrLogoPath"].toString().toLowerCase() != "null" &&
                          qrDetail["qrLogoPath"].toString().isNotEmpty
                      ? CustomCachedNetworkImage(
                          url: repo.baseUrl + qrDetail["qrLogoPath"],
                          fit: BoxFit.cover,
                          height: 3.h,
                        )
                      : Image.asset(
                          Assets.ismartLogo,
                          height: 3.h,
                        ),
                  qrDetail["imagePath"].toString().toLowerCase() != "null" &&
                          qrDetail["imagePath"].toString().isNotEmpty
                      ? CustomCachedNetworkImage(
                          url: repo.baseUrl + qrDetail["imagePath"],
                          fit: BoxFit.cover)
                      : Container(
                          height: 250.hp,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/qr infographics.png",
                                height: 200.hp,
                              ),
                              const Text(
                                "No External Qr found. Please request your Co-operative.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                  Image.asset(
                      RepositoryProvider.of<CoOperative>(context).bannerImage,
                      height: 10.h),
                ],
              ),
            ),
          ),
          if (qrDetail["qrType"] == "internal")
            Column(
              children: [
                KeyValueTile(
                  title: "Name",
                  value: detail.accountHolderName,
                ),
                KeyValueTile(
                  title: "Account Number",
                  value: detail.mainCode,
                ),
              ],
            ),
          if (qrDetail["qrType"] == "external")
            Column(
              children: [
                if (qrDetail["terminalName"].toString().toLowerCase() !=
                        "null" &&
                    qrDetail["terminalName"].toString().isNotEmpty)
                  KeyValueTile(
                    title: "Name",
                    value: qrDetail["terminalName"].toString(),
                  ),
                if (qrDetail["qrPhoneNumber"].toString().toLowerCase() !=
                        "null" &&
                    qrDetail["qrPhoneNumber"].toString().isNotEmpty)
                  KeyValueTile(
                    title: "Mobile Number",
                    value: qrDetail["qrPhoneNumber"].toString(),
                  ),
                if (qrDetail["terminalId"].toString().toLowerCase() != "null" &&
                    qrDetail["terminalId"].toString().isNotEmpty)
                  KeyValueTile(
                    title: "Terminal ID",
                    value: qrDetail["terminalId"].toString(),
                  ),
              ],
            ),
          qrDetail["imagePath"].toString().toLowerCase() != "null" &&
                  qrDetail["imagePath"].toString().isNotEmpty
              ? CustomRoundedButtom(
                  title: "Share",
                  onPressed: () async {
                    takeScreenshot();
                  },
                )
              : CustomRoundedButtom(
                  title: "Request QR",
                  onPressed: () async {
                    context.read<UtilityPaymentCubit>().makePayment(
                        serviceIdentifier: "",
                        accountDetails: {},
                        body: {},
                        apiEndpoint: "api/qrRequest",
                        mPin: "");
                  },
                ),
        ],
      ),
    );
  }
}

// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/widget/common_button.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class ExternalQrWidget extends StatefulWidget {
//   final String qrPath;

//   const ExternalQrWidget({super.key, required this.qrPath});

//   @override
//   _ExternalQrWidgetState createState() => _ExternalQrWidgetState();
// }

// class _ExternalQrWidgetState extends State<ExternalQrWidget> {
//   final screenShotController = ScreenshotController();
//   XFile? imageFile;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Screenshot(
//             controller: screenShotController,
//             child: buildWidget(),
//           ),
//         ),
//         CustomRoundedButtom(
//           title: "Share",
//           onPressed: () async {
//             takeScreenshot();
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildWidget() {
//     return SfPdfViewer.network(
//       "${RepositoryProvider.of<CoOperative>(context).baseUrl}${widget.qrPath}",
//     );
//   }

//   takeScreenshot() async {
//     final image = await screenShotController.capture();
//     final tempFile = await _createTempImageFile(image!);

//     if (tempFile != null) {
//       Share.shareFiles([tempFile.path]);
//     }
//   }

//   Future<XFile?> _createTempImageFile(Uint8List image) async {
//     try {
//       final directory = await getTemporaryDirectory();
//       const tempFileName = 'screenshot.png';
//       final tempFilePath = '${directory.path}/$tempFileName';

//       await File(tempFilePath).writeAsBytes(image);

//       return XFile(tempFilePath);
//     } catch (e) {
//       print('Error creating temp image file: $e');
//       return null;
//     }
//   }
// }
