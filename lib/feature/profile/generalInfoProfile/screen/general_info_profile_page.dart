import 'package:flutter/material.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/profile/generalInfoProfile/widget/general_info_profile_widget.dart';

class GeneralInfoProfilePage extends StatefulWidget {
  final ValueNotifier<CustomerDetailModel?> customerDetail;

  const GeneralInfoProfilePage({Key? key, required this.customerDetail})
      : super(key: key);

  @override
  State<GeneralInfoProfilePage> createState() => _GeneralInfoProfilePageState();
}

class _GeneralInfoProfilePageState extends State<GeneralInfoProfilePage> {
  @override
  Widget build(BuildContext context) {
    return GeneralInfoProfileWidget(
      customerDetail: widget.customerDetail,
    );
  }
}
