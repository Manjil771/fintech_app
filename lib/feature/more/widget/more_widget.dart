import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/feature/setting/screen/setting_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreWidget extends StatelessWidget {
  MoreWidget({Key? key}) : super(key: key);
  final List<String> itemImage = [
    Assets.discountCalculator,
    Assets.emiCalculator,
    Assets.downloadIcon,
    Assets.contactUsIcon,
    Assets.settingIcon,
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
      if (await canLaunchUrl(Uri.parse("tel:9801132218"))) {
        await launchUrl(Uri.parse("tel:9801132218"));
      } else {
        throw 'Could not launch tel:9801132218';
      }
    },
    () {
      NavigationService.push(target: SettingPage());
    },
    () {
      NavigationService.push(target: SettingPage());
    },
  ];

  final List names = [
    "Discount Calculator",
    "EMI Calculator",
    "Downloads",
    "Call Support",
    "Settings",
    // "FeedBack",
  ];
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return CommonContainer(
      showTitleText: false,
      body: Container(
        height: _height * 0.6,
        width: double.infinity,
        child: GridView.builder(
          itemCount: names.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return CommonGridViewContainer(
                onContainerPress: () => tapFunction[index](),
                containerImage: itemImage[index],
                title: names[index]);
          },
        ),
      ),
      topbarName: "More",
      showBackBotton: false,
      showDetail: false,
      showRoundBotton: false,
    );
  }
}
