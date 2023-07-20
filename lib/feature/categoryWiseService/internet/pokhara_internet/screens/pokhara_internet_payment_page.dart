import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/internet/pokhara_internet/widgets/pokhara_internet_payment_widget.dart';
import 'package:ismart/feature/categoryWiseService/internet/subisu/widgets/subisu_payment_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class PokharaInternetPaymentPage extends StatelessWidget {
  const PokharaInternetPaymentPage({super.key, required this.service});
  final service;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: PokharaInternetPaymentWidget(
        service: service,
      ),
    );
  }
}
