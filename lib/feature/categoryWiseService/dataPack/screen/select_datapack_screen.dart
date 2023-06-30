import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/widget/select_datapack_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class SelectDatapackScreen extends StatelessWidget {
  const SelectDatapackScreen({super.key, this.serviceIdentifier});
  final serviceIdentifier;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: SelectDatapackWidget(
        service: serviceIdentifier,
      ),
    );
  }
}
