import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/services/electricity/widget/electricity_payment_detail_widget.dart';

class ElectricityPaymentDetailPage extends StatelessWidget {
  const ElectricityPaymentDetailPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const ElectricityPaymentDetailWidget();
  }
}
