import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';

class ChequeBlockWidget extends StatelessWidget {
  const ChequeBlockWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Column(
      children: [
        CustomTextField(
          title: "Enter Cheque Number",
          hintText: "XXXXXXXXXXXXXX",
        ),
        SizedBox(height: _height * 0.02),
        CustomRoundedButtom(title: "Block Cheque", onPressed: () {}),
      ],
    );
  }
}
