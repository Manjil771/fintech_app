import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/constants.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/url_launcher.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class AppUpdateWidgets extends StatelessWidget {
  final bool isForceUpdate;
  const AppUpdateWidgets({Key? key, required this.isForceUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return WillPopScope(
      onWillPop: () async {
        return isForceUpdate ? false : true;
      },
      child: PageWrapper(
        leadingAppIcon: Container(),
        showAppBar: false,
        padding: EdgeInsets.zero,
        appBarLeftPadding: 0,
        appBarRightPadding: 0,
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                // aspectRatio: 1.3,
                width: SizeUtils.width,
                // height: SizeUtils.height,
                color: Colors.red,
                child: Expanded(
                  child: Image.asset(
                    isForceUpdate
                        ? Assets.forcedUpdateGraphics
                        : Assets.normalUpdateGraphics,
                    fit: BoxFit.fill,
                    width: SizeUtils.width,
                  ),
                ),
              ),
              SizedBox(height: 40.hp),
              Text(
                isForceUpdate
                    ? "You need to update your app to continue."
                    : "A new update is available.",
                style: _textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.hp),
              // Text(
              //   isForceUpdate
              //       ? "We added lots of new features and fix some bugs to make your experience as smooth as possible."
              //       : "We added lots of new features and fix some bugs to make your experience as smooth as possible.",
              //   textAlign: TextAlign.center,
              //   style: _textTheme.titleLarge!.copyWith(
              //     fontWeight: FontWeight.w400,
              //     color: CustomTheme.darkGray,
              //   ),
              // ),
              const Spacer(),
              CustomRoundedButtom(
                title: "Update Now",
                onPressed: () {
                  final String _appStoreID =
                      RepositoryProvider.of<CoOperative>(context).appStoreID;
                  final String _packageName =
                      RepositoryProvider.of<CoOperative>(context).packageName;
                  if (Platform.isAndroid) {
                    UrlLauncher.launchWebsite(
                      context: context,
                      url: Constants.googlePlayStore.tr(args: [_packageName]),
                    );
                  } else {
                    UrlLauncher.launchWebsite(
                      context: context,
                      url: Constants.appleAppStore.tr(args: [_appStoreID]),
                    );
                  }
                },
              ),
              SizedBox(height: 20.hp),
              if (isForceUpdate == false)
                CustomRoundedButtom(
                  title: "Will update later.",
                  color: _theme.scaffoldBackgroundColor,
                  textColor: _textTheme.titleLarge!.color ??
                      CustomTheme.lightTextColor,
                  onPressed: () {
                    NavigationService.pop();
                  },
                ),
              SizedBox(
                height: MediaQuery.of(context).viewPadding.bottom > 0
                    ? MediaQuery.of(context).viewPadding.bottom
                    : 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
