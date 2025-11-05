import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/allremittenace_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class AllremittanceDetailsPage extends StatelessWidget {
  final ScrollController scrollController;
  const AllremittanceDetailsPage({Key? key, required this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context))
        ..fetchDetails(
            serviceIdentifier: "",
            accountDetails: {},
            apiEndpoint: "api/remittance/getAllRemittance"),
      child: AllremittanceDetailsWidget(scrollController: scrollController),
    );
  }
}
