import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/constants.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/device_utils.dart';
import 'package:ismart/common/util/in_app_update_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/util/url_launcher.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';

class GeneralInfoProfileWidget extends StatefulWidget {
  final ValueNotifier<CustomerDetailModel?> customerDetail;
  const GeneralInfoProfileWidget({Key? key, required this.customerDetail})
      : super(key: key);

  @override
  State<GeneralInfoProfileWidget> createState() =>
      _GeneralInfoProfileWidgetState();
}

class _GeneralInfoProfileWidgetState extends State<GeneralInfoProfileWidget> {
  bool showPersonalDetail = false;

  String _appName = "";
  String _appVersion = "";

  _populateValue() async {
    _appName = await DeviceUtils.getAppName;
    _appVersion = await DeviceUtils.getAppVersion;

    print(_appName);
    print(_appVersion);
    setState(() {});
  }

  @override
  void initState() {
    _populateValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    final _detail = widget.customerDetail.value!;
    return PageWrapper(
      padding: EdgeInsets.zero,
      showAppBar: false,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                CommonDetailBox(
                  onBoxPressed: () {
                    setState(() {
                      showPersonalDetail = !showPersonalDetail;
                    });
                    print(showPersonalDetail.toString());
                  },
                  leadingImage: Assets.profileIcon,
                  title: "Personal Details".tr(),
                  detail: "Phone Number, Name , Address etc.",
                ),
                Visibility(
                  visible: showPersonalDetail,
                  child: Container(
                    color: _theme.scaffoldBackgroundColor,
                    height: _height * 0.19,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: buildDetails(
                                  context, "", "Name", "${_detail.fullName}"),
                            ),
                            SizedBox(
                              width: _width * 0.4,
                              child: buildDetails(
                                  context, "", "City", "${_detail.city}"),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: buildDetails(
                                  context, "", "DOB", "${_detail.dateOfBirth}"),
                            ),
                            SizedBox(
                              width: _width * 0.4,
                              child: buildDetails(
                                  context, "", "Gender", "${_detail.gender} "),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: buildDetails(
                                  context, "", "State", "${_detail.state}"),
                            ),
                            if (_detail.email.isNotEmpty)
                              SizedBox(
                                width: _width * 0.4,
                                child: buildDetails(
                                    context, "", "Email", "${_detail.email}"),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
                // : Container(),
                ,
                CommonDetailBox(
                  onBoxPressed: () async {
                    // final _isUpdateAvailable =
                    //     await InAppUpdateUtils.isUpdateAvailable;
                    // if (_isUpdateAvailable) {
                    //   if (Platform.isAndroid) {
                    //     InAppUpdateUtils.startFlexibleUpdate();
                    //   } else {
                    //     UrlLauncher.launchWebsite(
                    //       context: context,
                    //       url: Constants.appleAppStore,
                    //     );
                    //   }
                    // } else {
                    //   SnackBarUtils.showErrorBar(
                    //     context: context,
                    //     message: "No updates available.",
                    //   );
                    // }
                       SnackBarUtils.showErrorBar(
                        context: context,
                        message: "No updates available.",
                      );
                  },
                  leadingImage: Assets.downloadIcon,
                  title: "Check for Updates".tr(),
                  detail: "Never miss out any update.".tr(),
                ),
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
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _appName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.primaryColor,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "v" + _appVersion,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.primaryColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildDetails(BuildContext context, images, title, value) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/$images",
          height: size.height * 0.025,
        ),
        SizedBox(width: size.width * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        )
      ],
    );
  }
}
