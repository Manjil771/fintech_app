import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ismart/common/http/response.dart';
import 'package:ismart/common/util/image_picker_utils.dart';
import 'package:qr_code_utils/qr_code_utils.dart';

class QRUtils {
  static Future<DataResponse<String>> checkQRCodeFromGallery() async {
    final File? _file = await ImagePickerUtils.getGallery();
    if (_file != null) {
      try {
        final String data = await QrCodeUtils.decodeFrom(_file.path) ?? "";
        if (data.isEmpty) {
          return DataResponse.error("Invalid QR Code.");
        } else {
          return DataResponse.success(data);
        }
      } on PlatformException catch (e) {
        return DataResponse.error(e.message ?? "Invalid QR Code.");
      }
    } else {
      return DataResponse.error("");
    }
  }
}
