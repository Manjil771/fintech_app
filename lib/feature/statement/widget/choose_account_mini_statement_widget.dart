import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/statement/miniStatement/ui/screen/mini_statement_page.dart';

class ChooseAccountMiniStatementWidget extends StatelessWidget {
  const ChooseAccountMiniStatementWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        validateMobileBankingStatus: false,
        showDetail: true,
        showAccountSelection: true,
        accountTitle: "Select Account",
        topbarName: LocaleKeys.miniStatement.tr(),
        detail: "Select the Account you want to view statement of",
        buttonName: LocaleKeys.view.tr(),
        onButtonPressed: () {
          NavigationService.pushReplacement(target: const MiniStatementPage());
        },
        body: Container(),
      ),
    );
  }
}
