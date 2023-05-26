import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/receiveMoney/connectIps/widget/connect_ips_widget.dart';

class ConnectIpsPage extends StatelessWidget {
  const ConnectIpsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const ConnectIpsWidget();
  }
}
