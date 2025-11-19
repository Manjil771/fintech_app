import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/custom_locale.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/setting/language/language_setting.dart';
// import 'package:get/get.dart';
// import 'package:ismart/view/Auth/loginScreen/select_language.dart';

class IsmartTopWidget extends StatelessWidget {
  final Function()? supportAction;
  final bool showSupportIcon;
  const IsmartTopWidget(
      {Key? key, this.showSupportIcon = false, this.supportAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final repo = RepositoryProvider.of<CoOperative>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!repo.bannerImage.contains("https"))
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(
                repo.bannerImage,
                height: 60.hp,
              ),
            ),
          ),
        if (repo.bannerImage.contains("https"))
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.network(
                repo.bannerImage,
                height: 60.hp,
              ),
            ),
          ),
        if (showSupportIcon)
          Container(
            child: Row(
              children: [
                InkWell(
                  // onTap: () {
                  //   final Locale currentLocale = context.locale;
                  //   final Locale newLocale = currentLocale.languageCode == 'en'
                  //       ? CustomLocale.nepali
                  //       : CustomLocale.english;
                  //   context.setLocale(newLocale);
                  // },
                  onTap: () {
                    NavigationService.push(target: const LanguageSetting());
                  },
                  child: SvgPicture.asset(
                    Assets.translateImage,
                    height: _height * 0.03,
                  ),
                ),
                SizedBox(width: 15.hp),
                InkWell(
                  onTap: supportAction
                  // UrlLauncher.launchPhone(
                  //     context: NavigationService.context,
                  //     phone: "9801132218");
                  ,
                  child: SvgPicture.asset(
                    Assets.contactUsIcon,
                    height: _height * 0.03,
                  ),
                ),
              ],
            ),
          ),
        SizedBox(width: 15.hp),
      ],
    );
  }
}
