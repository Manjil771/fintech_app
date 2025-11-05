import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/smartloan/widget/smart_loan_apply_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class SmartLoanApplyScreen extends StatelessWidget {
  final double minLoanAmount;
  final double maxLoanAmount;

  const SmartLoanApplyScreen(
      {super.key, required this.minLoanAmount, required this.maxLoanAmount});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: SmartLoanApplyWidget(
        maxLoanAmount: maxLoanAmount,
        minLoanAmount: minLoanAmount,
      ),
    );
  }
}
