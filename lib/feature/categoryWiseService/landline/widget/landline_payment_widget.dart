import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class LandLinePaymentWidget extends StatelessWidget {
  const LandLinePaymentWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showAccountSelection: true,
        buttonName: "Pay",
        showDetail: true,
        title: "Landline Payement",
        detail: "Pay for your landline subscription from here.",
        topbarName: "Landline",
        body: Column(
          children: [
            CustomTextField(
              title: "Landline Number",
              hintText: "XXXXXXXXX",
            ),
            CustomTextField(
              title: "Amount",
              hintText: "NPR.",
            ),
          ],
        ),
      ),
    );
  }
}
