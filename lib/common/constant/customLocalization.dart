import 'package:flutter/material.dart';

class CustomBhojpuriLocalizations extends DefaultMaterialLocalizations {
  CustomBhojpuriLocalizations() : super();
}

class CustomMaithiliLocalizations extends DefaultMaterialLocalizations {
  CustomMaithiliLocalizations() : super();
}

class CustomNewariLocalizations extends DefaultMaterialLocalizations {
  CustomNewariLocalizations() : super();
}

class CustomBhojpuriLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomBhojpuriLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'bho';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return CustomBhojpuriLocalizations();
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<MaterialLocalizations> old) =>
      false;
}

class CustomMaithiliLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomMaithiliLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'mai';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return CustomMaithiliLocalizations();
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<MaterialLocalizations> old) =>
      false;
}

class CustomNewariLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomNewariLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'new';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return CustomNewariLocalizations();
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<MaterialLocalizations> old) =>
      false;
}
