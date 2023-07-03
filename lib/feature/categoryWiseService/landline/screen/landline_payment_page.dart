import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/landline/widget/landline_payment_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class LandLinePaymentPage extends StatelessWidget {
  final Service service;
  const LandLinePaymentPage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return LandLinePaymentWidget();
  }
}
