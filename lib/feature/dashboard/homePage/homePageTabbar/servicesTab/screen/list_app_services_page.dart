import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/services_model.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/widget/list_app_services_widget.dart';

class ListAppServicesPage extends StatelessWidget {
  final String topBarName;
  final services;
  const ListAppServicesPage(
      {Key? key, required this.services, required this.topBarName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ListAppServicesWidget(
      topBarName: topBarName,
      services: services,
    );
  }
}
