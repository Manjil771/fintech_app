import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ismart/app/app_prod.dart';
import 'package:ismart/app/local_wrapper.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/log.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await FlutterDownloader.initialize();
  }
  await EasyLocalization.ensureInitialized();
  runZonedGuarded(() {
    runApp(
      LocalWrapper(child: AppProd(env: CoOperativeValue.sanaKishanCoop)),
    );
  }, (e, s) {
    Log.e(e);
    Log.d(s);
  });
}
