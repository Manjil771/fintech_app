import 'package:flutter/material.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class BlueBookDetailWidget extends StatelessWidget {
  final UtilityResponseData response;

  const BlueBookDetailWidget({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      showBackButton: true,
      body: Center(
        child: Text("${response.findValue(primaryKey: 'totalPayableAmount')}"),
      ),
    );
  }
}
