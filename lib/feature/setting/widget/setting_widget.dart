import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/more/widget/more_widget.dart';
import 'package:ismart/feature/setting/language/language_setting.dart';
import 'package:ismart/feature/setting/preferences/preference_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  final ValueNotifier<bool> _isBiometricEnabled = ValueNotifier(false);

  // bool switchValue = false;

  @override
  void initState() {
    _checkBiometric();

    super.initState();
  }

  _checkBiometric() async {
    final bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
    if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
      _isBiometricEnabled.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      body: PageWrapper(
        body: CommonContainer(
          showDetail: false,
          showTitleText: false,
          showRoundBotton: false,
          verticalPadding: 0,
          topbarName: "Setting".tr(),
          body: Column(
            children: [
              // // checkBioMetric() == false
              // // ?
              // Row(
              //   children: [
              //     Expanded(
              //       child: CommonDetailBox(
              //         showTrailingIcon: false,
              //         leadingImage: "assets/icons/pin-code-svgrepo-com 1.svg",
              //         onBoxPressed: () {
              //           // NavigationService.push(target: const ChangeMpinPage());
              //         },
              //         title: "Biometric Setup",
              //         detail: "Enable/Disable biometric",
              //       ),
              //     ),
              //     ValueListenableBuilder<bool>(
              //         valueListenable: _isBiometricEnabled,
              //         builder: (context, val, child) {
              //           print("Default Value : Biometrics: $val");
              //           return Switch(
              //             value: val,
              //             onChanged: (value) async {
              //               print("Onchange Value : Biometrics: $value");
              //               if (value) {
              //                 NavigationService.pushReplacement(
              //                   target: BiometricLoginPage(
              //                     onValueCallback: (p0) {
              //                       NavigationService.pop();
              //                       if (p0) {
              //                         _isBiometricEnabled.value = value;
              //                         SharedPref.setBiometricLogin(true);
              //                         SnackBarUtils.showSuccessBar(
              //                           context: context,
              //                           message: "Biometric Enable",
              //                         );
              //                       }
              //                     },
              //                   ),
              //                 );
              //               } else {
              //                 _isBiometricEnabled.value = value;
              //                 SharedPref.setBiometricLogin(false);
              //                 SnackBarUtils.showErrorBar(
              //                   context: context,
              //                   message: "Biometric Disable",
              //                 );
              //               }
              //             },
              //           );
              //         })
              //   ],
              // ),
              // // : Container(),
              // const Divider(thickness: 1),
              // CommonDetailBox(
              //     leadingImage: "assets/icons/pin-code-svgrepo-com 1.svg",
              //     onBoxPressed: () {
              //       NavigationService.push(target: const ChangeMpinPage());
              //     },
              //     detail: "Change mPin frequently to be secure",
              //     title: "Change mPin"),

              // const Divider(thickness: 1),

              CommonDetailBox(
                  leadingImage: "assets/icons/privacy policy.svg",
                  onBoxPressed: _launchUrl,
                  detail: "View complete privacy policy".tr(),
                  title: "Privacy Policy".tr()),
              const Divider(thickness: 1),

              CommonDetailBox(
                  leadingImage: Assets.resetPinIcon,
                  onBoxPressed: () {
                    NavigationService.pushNamed(routeName: Routes.forgotPin);
                  },
                  detail: "Tap to reset your Security Pin.".tr(),
                  title: "Forget Pin".tr()),

              // const Divider(thickness: 1),
              // CommonDetailBox(
              //     leadingImage: Assets.preference,
              //     onBoxPressed: () {
              //       NavigationService.push(target: const PreferenceWidget());
              //     },
              //     detail: "Tap to set your preferences.",
              //     title: "Preferences"),
              const Divider(thickness: 1),
              CommonDetailBox(
                  leadingImage: Assets.translateImage,
                  onBoxPressed: () {
                    NavigationService.push(target: const LanguageSetting());
                  },
                  detail: "Tap to select the language.".tr(),
                  title: "Language".tr()),

              const Divider(thickness: 1),
              CommonDetailBox(
                onBoxPressed: () {
                  showPopUpDialog(
                    context: context,
                    message: "Are you sure you want to logout.".tr(),
                    title: "Alert".tr(),
                    buttonText: "Logout".tr(),
                    buttonCallback: () {
                      RepositoryProvider.of<UserRepository>(context).logout();
                      NavigationService.pushNamedAndRemoveUntil(
                        routeName: Routes.loginPage,
                      );
                    },
                  );
                },
                leadingImage: Assets.logoutIcon,
                title: "Logout".tr(),
                detail: "Logout from this application.".tr(),
              ),
              const Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}

final Uri _url = Uri.parse('https://devanasoft.com.np/PrivacyPolicy.html');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
