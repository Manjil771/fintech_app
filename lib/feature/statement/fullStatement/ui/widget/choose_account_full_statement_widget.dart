import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class ChooseAccountFullStatementWidget extends StatefulWidget {
  ChooseAccountFullStatementWidget({Key? key}) : super(key: key);

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
        showDetail: true,
        showAccountSelection: true,
        topbarName: "Statement",
        title: "Full Statement",
        detail: "Select the Account you want to view statement of",
        buttonName: "View",
        onButtonPressed: () {
          NavigationService.pushNamed(routeName: Routes.fullStatement);
        },
        body: Column(),
      ),
    );
  }
}
