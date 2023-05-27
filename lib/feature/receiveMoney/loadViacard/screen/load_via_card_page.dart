import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/receiveMoney/loadViacard/widget/load_via_card_widget.dart';

class LoadViaCardPage extends StatelessWidget {
  const LoadViaCardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const LoadViaCardWidget();
  }
}
