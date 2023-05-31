import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/profile/accountListProfile/widget/account_list_profile_widget.dart';
import 'package:ismart/feature/profile/generalInfoProfile/widget/general_info_profile_widget.dart';

class AccountListProfilePage extends StatelessWidget {
  final ValueNotifier<CustomerDetailModel?> customerDetail;

  const AccountListProfilePage({Key? key, required this.customerDetail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return AccountListProfileWidget(
      customerDetail: customerDetail,
    );
  }
}
