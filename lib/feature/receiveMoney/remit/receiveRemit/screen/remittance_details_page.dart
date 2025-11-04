import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/remittance_details_widgets.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class RemittanceDetailsPage extends StatelessWidget {
  final String companyID;
  final String imagePath;
  final String bankName;

  const RemittanceDetailsPage(
      {super.key,
      required this.companyID,
      required this.imagePath,
      required this.bankName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: RemittanceDetailsWidgets(
        imagePath: imagePath,
        companyID: companyID,
        bankName: bankName,
      ),
    );
  }
}
