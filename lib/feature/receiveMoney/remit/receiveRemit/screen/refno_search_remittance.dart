import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/refno_search_remit_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class RefnoSearchRemitPage extends StatelessWidget {
  final String companyName;
  final String imageUrl;

  final String serviceId;
  const RefnoSearchRemitPage(
      {super.key,
      required this.serviceId,
      required this.companyName,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: RefnoSearchRemitWidget(
        serviceId: serviceId,
        companyName: companyName,
        imageUrl: imageUrl,
      ),
    );
  }
}
