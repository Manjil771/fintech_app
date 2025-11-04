import 'package:flutter/material.dart';
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
    return CategoriesWiseServicesWidget(
      categoryIdentifier: uniqueIdentifier,
      topBarName: topBarName,
      services: services,
    );
  }
}
