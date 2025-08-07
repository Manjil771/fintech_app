import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/remittance_payment_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class RemittancepaymentPage extends StatelessWidget {
  final String pinNo;
  final String token;
  final String id;
  const RemittancepaymentPage(
      {super.key, required this.id, required this.token, required this.pinNo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context))
        ..fetchDetails(
            serviceIdentifier: "",
            accountDetails: {"id": id},
            apiEndpoint: "api/remittance/getPaymentConfirmOptions"),
      child: RemitteancePaymentWidget(
        pinNo: pinNo,
        token: token,
        id: id,
      ),
    );
  }
}
