import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class LoadViaCardWidget extends StatelessWidget {
  const LoadViaCardWidget({Key? key}) : super(key: key);
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
        accountTitle: "To Account",
        body: Column(
          children: [
            CustomTextField(
              title: "Charge",
              hintText: "NPR 10.00",
            ),
            CustomTextField(
              title: "Amount",
              hintText: "NPR",
            ),
            CustomTextField(
              title: "Remarks",
              hintText: "Remarks",
            )
          ],
        ),
        topbarName: "Receive Money",
        onButtonPressed: () {
          //TODO : button directs to mpin screen
        },
        buttonName: "Proceed",
        title: "Load via Card",
        detail: "Load fund instantly from your card.",
      ),
    );
  }
}
