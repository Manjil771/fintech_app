import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class CgPaymentWidget extends StatefulWidget {
  const CgPaymentWidget({Key? key, required this.service}) : super(key: key);
  final ServiceList service;

  @override
  State<CgPaymentWidget> createState() => _CgPaymentWidgetState();
}

class _CgPaymentWidgetState extends State<CgPaymentWidget> {
  @override
  Widget build(BuildContext context) {
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return const Placeholder();
  }
}
