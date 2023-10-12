import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/resource/bus_detail_model.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/available_bus_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class AvailableBusPage extends StatelessWidget {
  final ServiceList service;
  final UtilityResponseData response;
  final DateTime selectedDate;
  const AvailableBusPage(
      {Key? key,
      required this.service,
      required this.selectedDate,
      required this.response})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return AvailableBusWiget(
      response: response,
      service: service,
      selectedDate: selectedDate,
    );
  }
}
