import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/primary_account_box.dart';

class ChequeRequestWidget extends StatelessWidget {
  const ChequeRequestWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Column(
      children: [
        PrimaryAccountBox(),
        CustomTextField(
          readOnly: true,
          title: "Select Cheque Leaves",
          hintText: "10",
        ),
        SizedBox(height: _height * 0.02),
        CustomRoundedButtom(title: "Confirm", onPressed: () {}),
      ],
    );
  }
}
