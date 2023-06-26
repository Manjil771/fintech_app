import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/widget/category_wise_service_widget.dart';

class CategoriesWiseServicePage extends StatelessWidget {
  final String topBarName;
  final String uniqueIdentifier;

  final services;
  const CategoriesWiseServicePage(
      {Key? key,
      required this.services,
      required this.topBarName,
      required this.uniqueIdentifier})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return CategoriesWiseServicesWidget(
      uniqueIdentifier: uniqueIdentifier,
      topBarName: topBarName,
      services: services,
    );
  }
}
