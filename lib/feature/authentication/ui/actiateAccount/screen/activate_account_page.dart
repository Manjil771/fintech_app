import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/authentication/ui/actiateAccount/widget/activate_account_widget.dart';

class ActivateAccountPage extends StatelessWidget {
  const ActivateAccountPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ActivateAccountWidget();
  }
}
