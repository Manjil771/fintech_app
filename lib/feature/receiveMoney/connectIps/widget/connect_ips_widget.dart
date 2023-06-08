import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class ConnectIpsWidget extends StatelessWidget {
  const ConnectIpsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showAccountSelection: true,
        accountTitle: "To Account",
        body: Column(
          children: [
            CustomTextField(
              title: "Select Bank",
              hintText: "Select From List",
            ),
            CustomTextField(
              title: "Amount",
              hintText: "NPR",
            ),
            CustomTextField(
              title: "Charge",
              hintText: "NPR 10.00",
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
        title: "Connect IPS",
        detail: "You can load fund instantly from connect IPS",
      ),
    );
  }
}
