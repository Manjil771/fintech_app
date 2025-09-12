import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/custom_locale.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  Locale? currentLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Locale getLocale = context.locale;
      setState(() {
        currentLocale = getLocale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWrapper(
          body: CommonContainer(
        showRoundBotton: false,
        body: Container(
          child: Column(
            children: [
              RadioListTile<Locale>(
                title: const Text(
                  "English",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: CustomTheme.lightTextColor),
                ),
                value: CustomLocale.english,
                groupValue: currentLocale,
                onChanged: (value) async {
                  setState(() {
                    currentLocale = CustomLocale.english;
                  });
                  context.setLocale(CustomLocale.english);
                  showLoadingDialogBox(context);
                  await Future.delayed(const Duration(seconds: 2));
                  NavigationService.pop();
                  NavigationService.push(target: const DashboardPage());
                },
              ),
              const Divider(),
              RadioListTile<Locale>(
                title: const Text(
                  "नेपाली",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: CustomTheme.lightTextColor),
                ),
                value: CustomLocale.nepali,
                groupValue: currentLocale,
                onChanged: (value) async {
                  setState(() {
                    currentLocale = CustomLocale.nepali;
                  });
                  context.setLocale(CustomLocale.nepali);
                  showLoadingDialogBox(context);
                  await Future.delayed(const Duration(seconds: 2));
                  NavigationService.pop();
                  NavigationService.push(target: const DashboardPage());
                },
              ),
              const Divider(),
            ],
          ),
        ),
        topbarName: "Language",
      )),
    );
  }
}
