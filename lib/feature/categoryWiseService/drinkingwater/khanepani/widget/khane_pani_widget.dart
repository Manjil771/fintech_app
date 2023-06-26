import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class KhanePaniWidget extends StatelessWidget {
  const KhanePaniWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          buttonName: "Show Bill",
          showAccountSelection: true,
          title: "Khane Pani",
          detail: "Pay for your water bill from here.",
          showDetail: true,
          topbarName: "Khane Pani",
          body: Column(
            children: [
              CustomTextField(
                title: "Select Counter",
                hintText: "Select From List",
              ),
              CustomTextField(
                title: "Customer code",
                hintText: "XXXXXXXXX",
              ),
              CustomTextField(
                title: "Select Month",
                hintText: "Select From List",
              ),
            ],
          )),
    );
  }
}
