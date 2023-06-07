import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/qrCode/shareQr/widget/share_qr_widget.dart';

class ShareQrPage extends StatelessWidget {
  const ShareQrPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ShareQrWidget();
  }
}
