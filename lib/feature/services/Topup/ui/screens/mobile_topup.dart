import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/authentication/ui/widgets/login_widget.dart';
import 'package:ismart/feature/services/Topup/ui/widgets/mobile_topup_widget.dart';

class MobileTopupScreen extends StatelessWidget {
  const MobileTopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return MobileTopUpWidget();
  }
}
