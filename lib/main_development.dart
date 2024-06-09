import 'dart:async';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ismart/common/util/log.dart';

import 'app/app_dev.dart';
import 'app/local_wrapper.dart';
import 'common/constant/env.dart';

/// entrypoint to app in dev mode
Future<void> main() async {
  /// use run zoned to catch all uncaught exceptions
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!kIsWeb) {
      await FlutterDownloader.initialize();
    }
    await EasyLocalization.ensureInitialized();
    HttpOverrides.global = MyHttpOverrides();
    runApp(DevicePreview(
      enabled: false,
      builder: (context) =>
          LocalWrapper(child: AppDev(env: CoOperativeValue.currentCoop)),
    ));
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
