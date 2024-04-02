import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ExternalQrWidget extends StatelessWidget {
  final Map<String, dynamic> qrDetail;

  ExternalQrWidget({super.key, required this.qrDetail});
  final _screenShotController = ScreenshotController();
  XFile? imageFile;

  final detail =
      RepositoryProvider.of<CustomerDetailRepository>(NavigationService.context)
          .selectedAccount
          .value!;
  final repo = RepositoryProvider.of<CoOperative>(NavigationService.context);
  takeScreenshot() async {
    final image = await _screenShotController.capture();
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                qrDetail["terminalName"].toString().toLowerCase() != "null" &&
                        qrDetail["terminalName"].toString().isNotEmpty
                    ? CustomCachedNetworkImage(
                        url: repo.baseUrl + qrDetail["qrLogoPath"],
                        fit: BoxFit.cover,
                        height: 3.h,
                      )
                    : Image.asset(
                        Assets.ismartLogo,
                        height: 3.h,
                      ),
                CustomCachedNetworkImage(
                    url: repo.baseUrl + qrDetail["imagePath"],
                    fit: BoxFit.cover),
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
              if (qrDetail["terminalName"].toString().toLowerCase() != "null" &&
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
        CustomRoundedButtom(
          title: "Share",
          onPressed: () async {
            takeScreenshot();
          },
        ),
      ],
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
