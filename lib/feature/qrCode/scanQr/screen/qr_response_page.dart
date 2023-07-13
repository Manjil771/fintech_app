import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/qrCode/scanQr/widget/qr_response_widget.dart';

class QrREsponsePage extends StatelessWidget {
  final result;
  const QrREsponsePage({Key? key, this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return QrREsponseWidget(
      result: result,
    );
  }
}
