import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ismart/app/app_dev.dart';
import 'package:ismart/app/local_wrapper.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/log.dart';

/// entrypoint to app in dev mode
Future<void> main() async {
  /// use run zoned to catch all uncaught exceptions
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await FlutterDownloader.initialize();
    runApp(

      LocalWrapper(child: AppDev(env: CoOperativeValue.sudarshanCoop)),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
