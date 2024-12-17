import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/image_picker_utils.dart';
import 'package:qrcode_flutter/qrcode_flutter.dart';

class QRUtils {
  static Future<DataResponse<String>> checkQRCodeFromGallery() async {
    final File? _file = await ImagePickerUtils.getGallery();
    if (_file != null) {
      try {
        final String qrCodeResult =
            (await QRCaptureController.getQrCodeByImagePath(_file.path))
                .join("\n");
        if (qrCodeResult.isEmpty) {
          return DataResponse.error("Invalid QR Code.");
        } else {
          return DataResponse.success(qrCodeResult);
        }
      } on PlatformException catch (e) {
        return DataResponse.error(e.message ?? "Invalid QR Code.");
      }
    } else {
      return DataResponse.error("");
    }
  }
}
