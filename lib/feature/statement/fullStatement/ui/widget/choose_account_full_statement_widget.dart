import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/date_picker_dialog.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/statement/fullStatement/ui/screen/full_statement_page.dart';
import 'package:ismart/feature/statement/miniStatement/ui/screen/mini_statement_page.dart';

class ChooseAccountFullStatementWidget extends StatefulWidget {
  ChooseAccountFullStatementWidget({Key? key}) : super(key: key);

  @override
  State<ChooseAccountFullStatementWidget> createState() =>
      _ChooseAccountFullStatementWidgetState();
}

class _ChooseAccountFullStatementWidgetState
    extends State<ChooseAccountFullStatementWidget> {
  DateTime fromDate = DateTime.now().subtract(Duration(days: 90));
  DateTime toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        showAccountSelection: true,
        topbarName: "Statement",
        title: "Full Statement",
        detail: "Select the Account you want to view statement of",
        buttonName: "View",
        onButtonPressed: () {
          NavigationService.push(
              target: FullStatementPage(
            fromDate: fromDate,
            toDate: toDate,
          ));
        },
        body: Column(
          children: [
            CustomTextField(
              customHintTextStyle: true,
              readOnly: true,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: fromDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime.now());
                setState(() {
                  fromDate = picked!;
                });
              },
              showSuffixImage: true,
              title: "From Date",
              hintText: "${fromDate.year}-${fromDate.month}-${fromDate.day}",
            ),
            CustomTextField(
              showSuffixImage: true,
              customHintTextStyle: true,
              readOnly: true,
              hintText: "${toDate.year}-${toDate.month}-${toDate.day}",
              title: "To Date",
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: fromDate,
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime.now());
                setState(() {
                  toDate = picked!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
