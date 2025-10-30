import 'package:flutter/material.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/profile/accountListProfile/widget/account_list_profile_widget.dart';

class AccountListProfilePage extends StatefulWidget {
  final ValueNotifier<CustomerDetailModel?> customerDetail;

  const AccountListProfilePage({Key? key, required this.customerDetail})
      : super(key: key);

  @override
  State<AccountListProfilePage> createState() => _AccountListProfilePageState();
}

class _AccountListProfilePageState extends State<AccountListProfilePage> {
  @override
  Widget build(BuildContext context) {
    return AccountListProfileWidget(
      customerDetail: widget.customerDetail,
    );
  }
}
