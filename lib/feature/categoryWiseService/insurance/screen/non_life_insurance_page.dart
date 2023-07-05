import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/insurance/widget/non_life_insurance_widget.dart';

import '../../../dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class CommonInsurancePage extends StatelessWidget {
  final Service service;

  const CommonInsurancePage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return NonLifeInsurcnceWidget(
      service: service,
    );
  }
}
