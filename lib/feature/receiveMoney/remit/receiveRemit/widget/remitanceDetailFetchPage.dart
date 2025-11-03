import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/remittance_detail_fetch_widget.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/remittance_details_widgets.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class RemittanceDetailFetchPage extends StatelessWidget {
  final UtilityResponseData data;
  final String path;
  final String bankName;
  
  const RemittanceDetailFetchPage(
      {super.key,
      required this.data,
      required this.path,
      required this.bankName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: RemittanceDetailFetchWidget(
        path: path,
        data: data,
        bankName: bankName,
      ),
    );
  }
}
