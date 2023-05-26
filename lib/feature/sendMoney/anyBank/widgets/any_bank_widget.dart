import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class AnyBankWidget extends StatelessWidget {
  const AnyBankWidget({Key? key}) : super(key: key);
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
              hintText: "Select Bank",
              title: "Select Bank",
            ),
            CustomTextField(
              title: "Destination Account",
              hintText: "Destination Account Number",
            ),
            CustomTextField(
              hintText: "Account Holder Name",
            ),
            CustomTextField(
              title: "Amount",
              hintText: "NPR ",
            ),
            //TODO :need to add amount selection box
            CustomTextField(
              title: "Remarks",
              hintText: "Remarks",
            ),
          ],
        ),
        topbarName: "Send Money",
        buttonName: "Send",
        onButtonPressed: () {
          //TODO : Send Button Navigate to mpin screen
        },
        title: "Any Bank",
        detail: "Transfer funds to accounts held at various banks.",
      ),
    );
  }
}
