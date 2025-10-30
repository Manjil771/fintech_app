import 'dart:io';
import 'dart:math';

// import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  static final _picker = ImagePicker();

  static const int _maxFileSize = 2048;
  static const int _maxFileSizeVideo = 400000;

  static Future<File?> getCamera(
      {bool showOnlyFrontCamera = false, isVideo = false}) async {
    if (isVideo) {
      final pickedFile = await _picker.pickVideo(
          source: ImageSource.camera,
          preferredCameraDevice:
              showOnlyFrontCamera ? CameraDevice.front : CameraDevice.rear);

      return pickedFile != null ? (File(pickedFile.path)) : null;
      // return pickedFile != null ? compressVideo(File(pickedFile.path)) : null;
    } else {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice:
              showOnlyFrontCamera ? CameraDevice.front : CameraDevice.rear);

      // return pickedFile != null ? compressImage(File(pickedFile.path)) : null;
      return pickedFile != null ? (File(pickedFile.path)) : null;
    }
    // return null;
  }

  static Future<File?> getGallery({bool isVideo = false}) async {
    if (isVideo) {
      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

      return pickedFile != null ? (File(pickedFile.path)) : null;
      // return pickedFile != null ? compressVideo(File(pickedFile.path)) : null;
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      return pickedFile != null ? (File(pickedFile.path)) : null;
      // return pickedFile != null ? compressImage(File(pickedFile.path)) : null;
    }
  }

  // static Future<File?> compressImage(File file) async {
  //   final _fileSize = file.lengthSync() / 1024;
  //   if (_fileSize.ceil() < _maxFileSize) {
  //     return file;
  //   }
  //   final _percentage = 100 - (_maxFileSize / (file.lengthSync() / 1024));
  //   final result = await FlutterNativeImage.compressImage(
  //     file.absolute.path,
  //     percentage: _percentage.ceil(),
  //     quality: 80,
  //   );
  //   return result;
  // }

  // static Future<File?> compressVideo(File file) async {
  //   final _fileSize = file.lengthSync() / 1024;
  //   if (_fileSize.ceil() < _maxFileSizeVideo) {
  //     return file;
  //   }
  //   final _percentage = 100 - (_maxFileSize / (file.lengthSync() / 1024));
  //   final result = await FlutterNativeImage.compressImage(
  //     file.absolute.path,
  //     percentage: _percentage.ceil(),
  //     quality: 80,
  //   );
  //   return result;
  // }
}

getFileSize(String filepath, int decimals) async {
  final File file = File(filepath);
  final int bytes = await file.length();
  if (bytes <= 0) {
    return "0 B";
  }
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  final i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}

extension ImageExtension on File {
  bool get isImage {
    if (path.contains('jpg') || path.contains('png') || path.contains('jpeg')) {
      return true;
    } else {
      return false;
    }
  }

  bool get isVideo {
    if (path.contains('mp4')) {
      return true;
    } else {
      return false;
    }
  }
}
