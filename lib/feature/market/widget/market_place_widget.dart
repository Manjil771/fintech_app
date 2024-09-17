import 'package:flutter/material.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class MarketPlaceWidget extends StatelessWidget {
  const MarketPlaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      showBackButton: true,
      body: NoDataScreen(
          title: "Market Place",
          details: "This Service is currently under development."),
    );
  }
}
