import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/image_picker_utils.dart';
import 'package:qr_code_utils/qr_code_utils.dart';

class QRUtils {
  static Future<DataResponse<String>> checkQRCodeFromGallery() async {
    final File? _file = await ImagePickerUtils.getGallery();
    if (_file != null) {
      try {
        final Code resultFromPath =
            await zx.readBarcodeImagePathString(_file.path, DecodeParams());

        final String data = await QrCodeUtils.decodeFrom(_file.path) ?? "";

        final qrCodeResult = resultFromPath.text ?? "";
        if (qrCodeResult.isEmpty) {
          return DataResponse.error(
              "QR Payload Decoded as : $qrCodeResult Or $data");
        } else {
          return DataResponse.success(qrCodeResult);
        }
      } on PlatformException catch (e) {
        return DataResponse.error(
            e.message ?? "Invalid QR Code. Message : empty");
      }
    } else {
      return DataResponse.error("");
    }
  }
}
