import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String?> get getDownloadPath async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    if (externalStorageDirPath != null) {
      final savedDir = Directory(externalStorageDirPath);
      final hasExisted = savedDir.existsSync();
      if (!hasExisted) {
        await savedDir.create();
      }
    }
    return externalStorageDirPath;
  }

  static Future<String?> get getTemporaryDownloadPath async {
    final String temporaryStorageDirPath =
        (await getTemporaryDirectory()).absolute.path;
    final savedDir = Directory(temporaryStorageDirPath);
    final hasExisted = savedDir.existsSync();
    if (!hasExisted) {
      await savedDir.create();
    }
    return temporaryStorageDirPath;
  }
}
