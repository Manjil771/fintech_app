import 'package:flutter/material.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/widget/service_widget.dart';

class AllServiceWidget extends StatelessWidget {
  const AllServiceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return PageWrapper(
        body: CommonContainer(
      title: "asdasds",
      detail: "Asdsadsa",
      onButtonPressed: () {},
      showRoundBotton: false,
      topbarName: "All Services",
      body: ServicesWidget(),
    ));
  }
}
