import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/insurance/nepalLifeInsurance/widget/nepal_life_insurance_widget.dart';

class NepalLifeInsurancePage extends StatelessWidget {
  final String companyName;
  final String companyLogo;

  const NepalLifeInsurancePage(
      {Key? key, required this.companyName, required this.companyLogo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return NepalLifeInsurcnceWidget(
      companyLogo: companyName,
      companyName: companyLogo,
    );
  }
}
