import 'package:flutter/material.dart';
import 'package:ismart/feature/smartloan/widget/smart_loan_success_widget.dart';

class SmartLoanSuccessScreen extends StatelessWidget {
  final String message;

  const SmartLoanSuccessScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SmartLoanSuccessWidget(
      message: message,
    );
  }
}
