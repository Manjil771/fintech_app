import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/insurance/nepalLifeInsurance/widget/insurance_bill_detail_widget.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class InsuranceBillDetailPage extends StatelessWidget {
  const InsuranceBillDetailPage({Key? key, required this.detailFetchData})
      : super(key: key);
  final UtilityResponseData detailFetchData;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return InsuranceBillDetailWidget(
      detailFetchData: detailFetchData,
    );
  }
}
