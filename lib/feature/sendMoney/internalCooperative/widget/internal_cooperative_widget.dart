import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class InternalCooperativeWidget extends StatelessWidget {
  const InternalCooperativeWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        body: Column(
          children: [
            CustomTextField(
              title: "Destation Account",
              hintText: "Account Number",
            ),
            CustomTextField(
              hintText: "Account Holder Name",
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
        topbarName: "Send Money",
        onButtonPressed: () {
          //TODO : button directs to mpin screen
        },
        buttonName: "Proceed",
        title: "Internal Cooperative",
        detail: "Send Money to account maintained at same Coop.",
      ),
    );
  }
}
