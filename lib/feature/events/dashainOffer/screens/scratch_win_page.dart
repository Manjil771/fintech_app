import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/events/dashainOffer/widget/scratch_win_widget.dart';

class ScratchAndWinPage extends StatelessWidget {
  const ScratchAndWinPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ScratchAndWinWidget();
  }
}
