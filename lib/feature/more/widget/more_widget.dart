import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/url_launcher.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/feature/more/feedback/screen/feedback_page.dart';
import 'package:ismart/feature/setting/screen/setting_page.dart';

String _supportContact = "9801132218";
List<Map<String, dynamic>> _contactUsOptions = [
  {
    "title": "Call Support",
    "action": () {
      NavigationService.pop();
      UrlLauncher.launchPhone(
        context: NavigationService.context,
        phone: _supportContact,
      );
    },
  },
  {
    "title": "Chat on Viber",
    "action": () {
      NavigationService.pop();
      UrlLauncher.launchWebsite(
        context: NavigationService.context,
        url: "viber://chat?number=%2B977$_supportContact",
      );
    },
  },
  {
    "title": "Chat on WhatsApp",
    "action": () {
      NavigationService.pop();
      UrlLauncher.launchPhone(
        context: NavigationService.context,
        phone: "https://wa.me/%2B977$_supportContact",
      );
    },
  },
];

class MoreWidget extends StatelessWidget {
  MoreWidget({Key? key}) : super(key: key);
  final List<String> itemImage = [
    Assets.discountCalculator,
    Assets.emiCalculator,
    Assets.downloadIcon,
    Assets.contactUsIcon,
    Assets.settingIcon,
    Assets.feedBackIcon
    // Assets.settingIcon,
  ];
  List tapFunction = [
    () {
      NavigationService.pushNamed(routeName: Routes.discountCalculator);
    },
    () {
      NavigationService.pushNamed(routeName: Routes.emiCalculator);
    },
    () {
      NavigationService.pushNamed(routeName: Routes.downloadScreen);
    },
    () async {
      final _textTheme = Theme.of(NavigationService.context).textTheme;
      showModalBottomSheet(
        context: NavigationService.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.hp),
            topRight: Radius.circular(30.hp),
          ),
        ),
        builder: (context) => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 24),
                height: 4,
                width: 55,
                decoration: BoxDecoration(
                  color: CustomTheme.lightGray.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Text(
                "Choose Option",
                style: _textTheme.labelLarge!.copyWith(
                  color: CustomTheme.darkerBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Divider(
                height: 40,
              ),
              ...List.generate(
                _contactUsOptions.length,
                (index) {
                  return InkWell(
                    onTap: _contactUsOptions[index]['action'] as Function(),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.hp,
                        vertical: 15.hp,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _contactUsOptions[index]['title'],
                                    style: _textTheme.bodyLarge!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: CustomTheme.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    _supportContact,
                                    style: _textTheme.bodyLarge!.copyWith(
                                      color: CustomTheme.darkGray,
                                    ),
                                  )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: CustomTheme.primaryColor,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );

      // if (await canLaunchUrl(Uri.parse("tel:9801132218"))) {
      //   await launchUrl(Uri.parse("tel:9801132218"));
      // } else {
      //   throw 'Could not launch tel:9801132218';
      // }
    },
    () {
      NavigationService.push(target: const SettingPage());
    },
    () {
      NavigationService.push(target: FeedBackPage());
    },
  ];

  final List names = [
    "Discount Calculator",
    "EMI Calculator",
    "Downloads",
    "Support",
    "Settings",
    if (RepositoryProvider.of<CoOperative>(NavigationService.context)
            .clientCode ==
        "EHVNI7CZJ3")
      "FeedBack",
  ];
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return CommonContainer(
      showTitleText: false,
      body: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: names.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return CommonGridViewContainer(
              onContainerPress: () => tapFunction[index](),
              containerImage: itemImage[index],
              title: names[index]);
        },
      ),
      topbarName: "More",
      showBackBotton: false,
      showDetail: false,
      showRoundBotton: false,
    );
  }
}
