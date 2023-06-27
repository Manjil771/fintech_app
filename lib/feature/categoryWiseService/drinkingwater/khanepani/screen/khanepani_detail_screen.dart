import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/widget/khanepani_detail_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class KhanepaniDetailsPage extends StatelessWidget {
  final UtilityResponseData useServiceResponse;
  final String counterName;
  final String customerCode;
  final String counterCode;

  const KhanepaniDetailsPage({
    Key? key,
    required this.counterName,
    required this.customerCode,
    required this.useServiceResponse,
    required this.counterCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
        utilityPaymentRepository:
            RepositoryProvider.of<UtilityPaymentRepository>(context),
      ),
      child: KhanepaniDetailsWidgets(
        counterName: counterName,
        customerCode: customerCode,
        useServiceResponse: useServiceResponse,
        counterCode: counterCode,
      ),
    );
  }
}
