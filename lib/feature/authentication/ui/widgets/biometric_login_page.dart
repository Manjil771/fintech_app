import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/fingerprint_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/ismart_top_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';

class BiometricLoginPage extends StatelessWidget {
  const BiometricLoginPage({Key? key, required this.onValueCallback})
      : super(key: key);

  final Function(bool) onValueCallback;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      showAppBar: false,
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const IsmartTopWidget(),
          SizedBox(
            height: 20.hp,
          ),
          Text(
            "Enable Biometric",
            style: _textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.hp,
          ),
          SvgPicture.asset(
            Assets.fingerPrintImage,
            height: 100,
          ),
          SizedBox(
            height: 15.hp,
          ),
          Text(
            "Enable biometric login to login without your Security Pin.",
            style: _textTheme.bodyLarge,
          ),
          SizedBox(
            height: 20.hp,
          ),
          CustomRoundedButtom(
            title: "Enable Now",
            onPressed: () async {
              final bool _isFingerprintAvailable =
                  await FingerPrintUtils.hasFingerPrint;
              if (_isFingerprintAvailable) {
                onValueCallback(
                  await FingerPrintUtils.verifyFingerPrint(
                    context: context,
                    reason: "Enable biometric login.",
                  ),
                );
              }
            },
          ),
          SizedBox(
            height: 15.hp,
          ),
          CustomRoundedButtom(
            title: "Continue without Biometric",
            onPressed: () {
              SharedPref.setBiometricLogin(false);
              NavigationService.pushReplacement(
                target: const DashboardPage(),
              );
            },
            icon: Icons.arrow_forward_ios,
            color: CustomTheme.backgroundColor,
            textColor: CustomTheme.primaryColor,
            iconColor: CustomTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}
