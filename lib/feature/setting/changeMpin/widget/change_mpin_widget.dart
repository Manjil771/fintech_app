import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class ChangeMpinWidget extends StatelessWidget {
  TextEditingController oldPinController = TextEditingController();

  TextEditingController newPinController = TextEditingController();
  TextEditingController reEnterPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        title: "Change PIN",
        showDetail: true,
        detail: "Enter a unique PIN Code.",
        topbarName: "Settings",
        buttonName: "Submit",
        onButtonPressed: () {},
        body: Column(
          children: [
            CustomTextField(
                controller: oldPinController,
                title: "Old MPin",
                hintText: "XXXXXXX"),
            SizedBox(height: _height * 0.02),
            CustomTextField(
                controller: newPinController,
                title: "New MPin",
                hintText: "XXXXXXX"),
            SizedBox(height: _height * 0.02),
            CustomTextField(
                controller: reEnterPinController,
                title: "Re-Enter MPin",
                hintText: "XXXXXXX"),
          ],
        ),
      ),
    );
  }
}
