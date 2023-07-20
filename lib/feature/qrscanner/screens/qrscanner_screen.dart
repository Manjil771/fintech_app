import 'package:flutter/material.dart';
import 'package:ismart/feature/qrscanner/widgets/qrscanner_widget.dart';

class QRScannerScreens extends StatelessWidget {
  // final ValueChanged<MpqrcDetail> onScanned;
  // final QRType type;
  const QRScannerScreens({
    Key? key,
    // required this.onScanned,
    // required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const QRScannerWidgets(
        // onScanned: onScanned,
        // type: type,
        );
  }
}
