import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/statement/fullStatement/ui/screen/choose_account_full_statement_page.dart';
import 'package:ismart/feature/statement/miniStatement/ui/screen/choose_account_mini_statement_page.dart';

class StatementWidget extends StatelessWidget {
  const StatementWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: false,
        topbarName: "Statement",
        title: "Statement",
        detail: "Select the type of statement you want to  view",
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
                          NavigationService.push(
                              target: ChooseAccountMiniStatementPage());
                        },
                        containerImage: Assets.miniStatement,
                        title: "Mini Statement"),
                  ),
                  Expanded(
                    child: CommonGridViewContainer(
                        containerImage: Assets.miniStatement,
                        title: "Full Statement",
                        onContainerPress: () {
                          NavigationService.push(
                              target: ChooseAccountFullStatementPage());
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
