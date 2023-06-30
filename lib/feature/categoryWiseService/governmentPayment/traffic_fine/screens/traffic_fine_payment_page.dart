import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/traffic_fine/widget/traffic_fine_payment_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class TrafficFinePaymentPage extends StatelessWidget {
  final Service service;
  const TrafficFinePaymentPage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return TrafficFinePaymentWidget(
      service: service,
    );
  }
}
