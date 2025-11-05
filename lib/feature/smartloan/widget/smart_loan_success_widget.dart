import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class SmartLoanSuccessWidget extends StatelessWidget {
  final String message;
  const SmartLoanSuccessWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      showBackButton: true,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset(Assets.instaLoanSuccessIcon),
                ),
                Text(
                  message,
                  // "Congratulations! Your loan amount of NPR XXX has been successfully addes to your Coop account Thank You!",
                  style: _textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.hp),
                CustomRoundedButtom(
                    title: "Done",
                    onPressed: () {
                      NavigationService.pushNamedAndRemoveUntil(
                          routeName: Routes.dashboard);
                    }),
                SizedBox(height: 20.hp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
