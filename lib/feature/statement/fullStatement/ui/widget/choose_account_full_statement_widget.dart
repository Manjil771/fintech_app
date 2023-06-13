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
  DateTime? fromDate;

  DateTime? toDate;
  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != (isFromDate ? fromDate : toDate)) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

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
          NavigationService.push(target: FullStatementPage());
        },
        body: Column(children: [
          CustomTextField(
            hintText: "From Date:$fromDate  To Date :$toDate",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Select Date Range'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        child: Text(fromDate != null
                            ? 'From Date: ${fromDate.toString().split(' ')[0]}'
                            : 'Select From Date'),
                        onPressed: () => _selectDate(context, true),
                      ),
                      ElevatedButton(
                        child: Text(toDate != null
                            ? 'To Date: ${toDate.toString().split(' ')[0]}'
                            : 'Select To Date'),
                        onPressed: () => _selectDate(context, false),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                      child: Text('OK'),
                      onPressed: () {
                        // Do something with the selected dates
                        print(
                            'From Date: ${fromDate!.year}-${fromDate!.month}-${fromDate!.day}');
                        print(
                            'To Date:${toDate!.year}-${toDate!.month}-${toDate!.day}');
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            readOnly: true,
            title: "Select Date",
          ),
        ]),
      ),
    );
  }
}
