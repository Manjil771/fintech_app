import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/statement/widget/choose_account_mini_statement_widget.dart';

class ChooseAccountMiniStatementPage extends StatelessWidget {
  const ChooseAccountMiniStatementPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ChooseAccountMiniStatementWidget();
  }
}
