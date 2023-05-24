import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/dashboardTabbar/servicesTab/widget/service_widget.dart';

class AllServiceWidget extends StatelessWidget {
  const AllServiceWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
      onButtonPressed: () {},
      showRoundBotton: false,
      topbarName: "All Services",
      body: ServicesWidget(),
    ));
  }
}
