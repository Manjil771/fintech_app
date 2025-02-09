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
      String? resultFromPath;
      String data = "";   
      String error = "";
      try {
        resultFromPath =
            (await zx.readBarcodeImagePathString(_file.path, DecodeParams())).text; }catch(e){
              error=error + "Error on 1 $e";
            }
        try{
         data = await QrCodeUtils.decodeFrom(_file.path) ?? "";

        
      } on PlatformException catch (e) {
        error =error + "Error on 2 $e ";
        // return DataResponse.error(
        //     e.message ?? "Invalid QR Code. Message : empty");
      }

      if(resultFromPath != null && resultFromPath.isNotEmpty){
        return DataResponse.success(resultFromPath.trim());
      }else if(data.isNotEmpty){
        return DataResponse.success(data.trim());
      }else{

      // final qrCodeResult = resultFromPath ?? "";
      //   if (qrCodeResult.isEmpty) {
          return DataResponse.error(
              "Error when decoding QR. Please try another image.");
        // } else {
        //   return DataResponse.success(qrCodeResult);
        // }

        }
    } else {
      return DataResponse.error("");
    }
  }
}
