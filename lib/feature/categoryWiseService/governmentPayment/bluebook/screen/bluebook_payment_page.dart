import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/bluebook/widget/bluebook_payment_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class BlueBookRenewalPage extends StatelessWidget {
  final ServiceList service;
  const BlueBookRenewalPage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlueBookRenewalWidget(
      service: service,
    );
  }
}
