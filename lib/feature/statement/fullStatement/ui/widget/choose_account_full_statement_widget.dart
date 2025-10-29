import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class ChooseAccountFullStatementWidget extends StatefulWidget {
  const ChooseAccountFullStatementWidget({Key? key}) : super(key: key);

  @override
  State<ChooseAccountFullStatementWidget> createState() =>
      _ChooseAccountFullStatementWidgetState();
}

class _ChooseAccountFullStatementWidgetState
    extends State<ChooseAccountFullStatementWidget> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        validateMobileBankingStatus: false,
        showDetail: true,
        showAccountSelection: true,
        topbarName: LocaleKeys.statement.tr(),
        detail: "Select the Account you want to view statement of",
        buttonName: "View",
        onButtonPressed: () {
          NavigationService.pushNamed(routeName: Routes.fullStatement);
        },
        body: const Column(),
      ),
    );
  }
}
