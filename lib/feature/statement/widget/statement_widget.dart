import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class StatementWidget extends StatelessWidget {
  const StatementWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: false,
        topbarName: LocaleKeys.statement1.tr(),
        detail: LocaleKeys.toptext.tr(),
        showRoundBotton: false,
        body: Column(
          children: [
            Container(
              height: _height * 0.19,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: CommonGridViewContainer(
                        onContainerPress: () {
                          NavigationService.pushNamed(
                              routeName: Routes.chooseAccountMiniStatement);
                        },
                        containerImage: Assets.miniStatement,
                        title: LocaleKeys.miniStatement.tr()),
                  ),
                  Expanded(
                    child: CommonGridViewContainer(
                        containerImage: Assets.miniStatement.tr(),
                        title: LocaleKeys.fullStatement.tr(),
                        onContainerPress: () {
                          NavigationService.pushNamed(
                              routeName: Routes.chooseAccountFullStatement);
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
