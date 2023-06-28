import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/banking/cheque/widget/cheque_block_widget.dart';

class ChequeBlocScreen extends StatelessWidget {
  const ChequeBlocScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ChequeBlockWidget();
  }
}
