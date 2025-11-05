// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:flutter_zxing/flutter_zxing.dart';
// import 'package:ismart/common/http/response.dart';
// import 'package:ismart/common/util/image_picker_utils.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:qr_code_utils/qr_code_utils.dart';

// class QRUtils {
//   static Future<DataResponse<String>> checkQRCodeFromGallery() async {
//     final File? _file = await ImagePickerUtils.getGallery();
//     if (_file != null) {
//       String? resultFromPath;
//       String data = "";
//       String error = "";
//       try {
//         resultFromPath =
//             (await zx.readBarcodeImagePathString(_file.path, DecodeParams()))
//                 .text;
//       } catch (e) {
//         error = error + "Error on 1 $e";
//       }
//       try {
//         data = await QrCodeUtils.decodeFrom(_file.path) ?? "";
//       } on PlatformException catch (e) {
//         error = error + "Error on 2 $e ";
//         // return DataResponse.error(
//         //     e.message ?? "Invalid QR Code. Message : empty");
//       }

//       if (resultFromPath != null && resultFromPath.isNotEmpty) {
//         return DataResponse.success(resultFromPath.trim());
//       } else if (data.isNotEmpty) {
//         return DataResponse.success(data.trim());
//       } else {
//         // final qrCodeResult = resultFromPath ?? "";
//         //   if (qrCodeResult.isEmpty) {
//         return DataResponse.error(
//             "Error when decoding QR. Please try another image.");
//         // } else {
//         //   return DataResponse.success(qrCodeResult);
//         // }
//       }
//     } else {
//       return DataResponse.error("");
//     }
//   }
// }
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/image_picker_utils.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRUtils {
  static Future<DataResponse<String>> checkQRCodeFromGallery() async {
    final File? originalFile = await ImagePickerUtils.getGallery();
    if (originalFile == null) {
      return DataResponse.error("Image selection cancelled");
    }
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: originalFile.path,
      compressQuality: 90,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop QR Code',
          toolbarColor: CustomTheme.primaryColor,
          toolbarWidgetColor: CustomTheme.white,
          statusBarColor: CustomTheme.white,
          backgroundColor: CustomTheme.primaryColor,
          initAspectRatio: CropAspectRatioPreset.square,
          dimmedLayerColor: CustomTheme.primaryColor.withAlpha(150),
          lockAspectRatio: true,
          showCropGrid: true,
        ),
        IOSUiSettings(
          title: 'Crop QR Code',
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
          resetAspectRatioEnabled: false,
          aspectRatioLockDimensionSwapEnabled: true,
          resetButtonHidden: true,
          doneButtonTitle: 'Apply',
          cancelButtonTitle: 'Back',
        ),
      ],
    );

    if (croppedFile == null) {
      return DataResponse.error("Image cropping cancelled");
    }

    final File fileToScan = File(croppedFile.path);
    final controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      detectionTimeoutMs: 3000,
    );

    try {
      final BarcodeCapture? capture =
          await controller.analyzeImage(fileToScan.path);
      if (capture != null && capture.barcodes.isNotEmpty) {
        final detectedBarcode = capture.barcodes.firstWhere(
          (barcode) => barcode.rawValue != null,
          orElse: () => capture.barcodes.first,
        );

        if (detectedBarcode.rawValue != null) {
          return DataResponse.success(detectedBarcode.rawValue!.trim());
        }
      }
      return DataResponse.error("No QR code found in the image");
    } catch (e) {
      return DataResponse.error("QR decoding error: ${e.toString()}");
    } finally {
      controller.dispose();
    }
  }
}
