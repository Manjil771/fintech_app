// import 'dart:async';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:ismart/app/app_prod.dart';
// import 'package:ismart/app/local_wrapper.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/util/log.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();

//   runZonedGuarded(() {
//     runApp(
//       LocalWrapper(
//           child: AppProd(env: CoOperativeValue.chandraGiriCoOperative)),
//     );
//   }, (e, s) {
//     Log.e(e);
//     Log.d(s);
//   });
// }
