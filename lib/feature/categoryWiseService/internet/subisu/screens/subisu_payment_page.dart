import 'package:flutter/material.dart';
import 'package:ismart/feature/categoryWiseService/internet/subisu/widgets/subisu_payment_widget.dart';

class SubisuPaymentPage extends StatelessWidget {
  const SubisuPaymentPage({super.key, required this.service});
  final service;

  @override
  Widget build(BuildContext context) {
    return SubisuPaymentWidget(
      service: service,
    );
  }
}
