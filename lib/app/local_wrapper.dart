import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/constant/custom_locale.dart';

class LocalWrapper extends StatelessWidget {
  final Widget _child;
  const LocalWrapper({required Widget child}) : _child = child;
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: const [
        Locale("en"),
        Locale("ne"),
        Locale("bho"),
        Locale("mai"),
        Locale("new"),
      ],
      path: "assets/translations",
      fallbackLocale: CustomLocale.english,
      child: _child,
    );
  }
}
