import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/search_flight_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class SearchFlightScreen extends StatelessWidget {
  const SearchFlightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UtilityPaymentCubit(
            utilityPaymentRepository:
                RepositoryProvider.of<UtilityPaymentRepository>(context)),
        child: SearchFlightWidget());
  }
}
