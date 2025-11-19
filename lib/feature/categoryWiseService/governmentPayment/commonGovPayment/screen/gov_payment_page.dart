import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/commonGovPayment/widget/gov_payment_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class GovernmentPaymentPage extends StatelessWidget {
  const GovernmentPaymentPage({super.key, required this.services});
  final services;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UtilityPaymentCubit(
            utilityPaymentRepository:
                RepositoryProvider.of<UtilityPaymentRepository>(context)),
        child: GovPaymentWidget(
          service: services,
        ));
  }
}
