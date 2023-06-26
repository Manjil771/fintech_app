import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/transaction_success_screen.dart';
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
    Assets.settingIcon,
  ];
  List tapFunction = [
    () {
      NavigationService.pushNamed(routeName: Routes.discountCalculator);
    },
    () {
      NavigationService.pushNamed(routeName: Routes.emiCalculator);
    },
    () {
      // NavigationService.push(target: EmiCalculatorPage());
    },
    () {
      String url = "tel://214324234";

      Future<void> makeUrlRequest(String url) async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          throw 'Could not launch $url';
        }
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
