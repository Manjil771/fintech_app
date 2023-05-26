import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/widgets/dashboard_tabbar_widget.dart';
import 'package:ismart/feature/dashboard/widgets/dashboard_user_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      // showAppBar: true,
      body: Column(
        children: [
          const DashBoardUserWidget(),
          SizedBox(height: _height * 0.02),
          Row(
            children: [
              Expanded(
                  child: InkWell(
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
                      const Text("Send"),
                    ],
                  ),
                ),
              )),
              SizedBox(width: _width * 0.2),
              Expanded(
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
                    const Text("Receive"),
                  ],
                ),
              ))
            ],
          ),
          const Expanded(child: DashboardTabbarWidget())
        ],
      ),
    );
  }
}
