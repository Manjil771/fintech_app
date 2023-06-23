import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class ElectricityPaymentDetailWidget extends StatelessWidget {
  const ElectricityPaymentDetailWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: false,

        title: "NEA Payment",
        detail: "Pay for your electricity bill from here.",
        topbarName: "Payment",
        body: Container(), //TODO need to show response from api
        buttonName: "Proceed",
      ),
    );
  }
}
