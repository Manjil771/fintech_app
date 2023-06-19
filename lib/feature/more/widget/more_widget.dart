import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/feature/more/emiCalculator/emi_calculator_page.dart';

class MoreWidget extends StatelessWidget {
  MoreWidget({Key? key}) : super(key: key);
  final List<String> itemImage = [
    Assets.discountCalculator,
    Assets.emiCalculator,
    Assets.downloadIcon,
    Assets.contactUsIcon,
    Assets.settingIcon,
  ];
  final List names = [
    "Discount Calculator",
    "EMI Calculator",
    "Downloads",
    "Call Support",
    "Settings",
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
          itemCount: 5,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return CommonGridViewContainer(
                onContainerPress: () {
                  NavigationService.push(target: EmiCalculatorPage());
                },
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
