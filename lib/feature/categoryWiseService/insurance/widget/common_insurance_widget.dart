import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class CommonInsuranceWidget extends StatelessWidget {
  const CommonInsuranceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          showAccountSelection: true,
          buttonName: "See Details",
          title: "Insurance Payment",
          detail: "Pay for your insurance bill from here.",
          body: Column(children: [
            CustomTextField(
              hintText: "Policy Number",
              title: "Policy Number",
            ),
          ]),
          topbarName: "Insurance",
          showDetail: true),
    );
  }
}
