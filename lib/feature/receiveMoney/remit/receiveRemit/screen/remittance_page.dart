import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/remittance_widget.dart';

class ReceiveRemittancePage extends StatelessWidget {
  const ReceiveRemittancePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const ReceiveRemittanceWidget();
  }
}
