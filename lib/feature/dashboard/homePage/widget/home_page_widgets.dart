import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_icon_button.dart';
import 'package:ismart/common/widget/custom_image_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/screen/homepage_money_page.dart';

import 'home_page_tabbar_widget.dart';
import 'home_page_user_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      padding: EdgeInsets.zero,
      showAppBar: false,
      body: Column(
        children: [
          const HomePageUserWidget(),
          SizedBox(height: _height * 0.02),
          // Container(height: 68.hp, child: HomePageMoneyPage())

          Row(
            children: [
              Expanded(
                  child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  NavigationService.pushNamed(routeName: Routes.reveiveMoney);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomTheme.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: _height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: _theme.primaryColor.withOpacity(0.16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            Assets.reveiceMoneyIcon,
                            color: _theme.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: _width * 0.02),
                      Text(
                        "Receive",
                        style: _textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              )),
              SizedBox(width: _width * 0.1),
              Expanded(
                  child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  NavigationService.pushNamed(routeName: Routes.sendMoney);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomTheme.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: _height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: _theme.primaryColor.withOpacity(0.16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            Assets.sendMoneyIcon,
                            color: _theme.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: _width * 0.02),
                      Text(
                        "Send",
                        style: _textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),

          const Expanded(child: HomePageTabbarWidget())
        ],
      ),
    );
  }
}
