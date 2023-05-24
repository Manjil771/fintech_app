import 'package:flutter/material.dart';
import 'package:ismart/feature/dashboard/dashboardTabbar/servicesTab/widget/service_widget.dart';

class ServicesPage extends StatelessWidget {
  final bool showAllServices;

  const ServicesPage({super.key, required this.showAllServices});
  @override
  Widget build(BuildContext context) {
    return ServicesWidget(
      showAllService: showAllServices,
    );
  }
}
