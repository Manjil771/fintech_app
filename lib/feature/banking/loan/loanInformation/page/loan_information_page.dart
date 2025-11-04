import 'package:flutter/material.dart';
import 'package:ismart/feature/banking/loan/loanInformation/widget/loan_informtaion_widget.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LoanInformationPage extends StatelessWidget {
  final UtilityResponseData response;
  const LoanInformationPage({Key? key, required this.response})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoanInformationWiget(
      response: response,
    );
  }
}
