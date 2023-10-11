import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/available_bus_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class AvailableBusPage extends StatelessWidget {
  final ServiceList service;
  final DateTime selectedDate;
  const AvailableBusPage(
      {Key? key, required this.service, required this.selectedDate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return AvailableBusWiget(
      service: service,
      selectedDate: selectedDate,
    );
  }
}
