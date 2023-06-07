import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/banking/balanceInquiry/cheque/widget/cheque_request_widget.dart';

class ChequeRequestScreen extends StatelessWidget {
  const ChequeRequestScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ChequeRequestWidget();
  }
}
