import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/payload/widget/payload_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class PayloadPage extends StatelessWidget {
  final String? payload;
  final String? remarks;

  const PayloadPage({Key? key, this.payload, this.remarks}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context))
        ..fetchDetails(
            serviceIdentifier: "",
            apiEndpoint: "/api/qpay/merchant_detail",
            accountDetails: {
              "pay_load": payload,
            }),
      child: PayloadWidget(
        remarks: remarks,
        payload: payload,
      ),
    );
  }
}
