import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class MobileBankingWidget extends StatelessWidget {
  const MobileBankingWidget({Key? key}) : super(key: key);
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
              title: "Amount",
              hintText: "NPR ",
            ),
            //TODO :need to add amount selection box
            CustomTextField(
              title: "Charge",
              hintText: "NPR 10.00",
            ),
            CustomTextField(
              title: "Remarks",
              hintText: "Remarks",
            ),
          ],
        ),
        topbarName: "Receive Money",
        buttonName: "Proceed",
        onButtonPressed: () {
          //TODO : Send Button Navigate to mpin screen
        },
        title: "Mobile Banking",
        detail: "Load fund instantly from mobile banking.",
      ),
    );
  }
}
