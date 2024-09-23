import 'package:flutter/material.dart';
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
        topbarName: "Mini Statement",
        detail: "Select the Account you want to view statement of",
        buttonName: "View",
        onButtonPressed: () {
          NavigationService.pushReplacement(target: const MiniStatementPage());
        },
        body: Container(),
      ),
    );
  }
}
