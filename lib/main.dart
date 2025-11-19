import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ismart/app/app_prod.dart';
import 'package:ismart/app/local_wrapper.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/log.dart';

import 'main_development.dart';

Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await FlutterDownloader.initialize();
  }
  await EasyLocalization.ensureInitialized();
  runZonedGuarded(() {
    HttpOverrides.global = MyHttpOverrides();
    runApp(
      LocalWrapper(child: AppProd(env: CoOperativeValue.currentCoop)),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
