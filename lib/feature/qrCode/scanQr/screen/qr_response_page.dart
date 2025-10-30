import 'package:flutter/material.dart';
import 'package:ismart/feature/qrCode/scanQr/widget/qr_response_widget.dart';

class QrREsponsePage extends StatelessWidget {
  final result;
  const QrREsponsePage({Key? key, this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return QrREsponseWidget(
      result: result,
    );
  }
}
