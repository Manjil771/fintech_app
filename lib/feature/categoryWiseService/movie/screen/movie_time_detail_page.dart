import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/movie/widget/movie_time_detail_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class MovieTimeDetailPage extends StatelessWidget {
  final String showId;
  final String processId;
  final selectedMovie;

  const MovieTimeDetailPage(
      {super.key,
      required this.showId,
      required this.processId,
      required this.selectedMovie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context))
        ..fetchDetails(
            serviceIdentifier: "",
            accountDetails: {
              "showId": showId,
              "processId": processId,
            },
            apiEndpoint: "/api/movie/showinfo"),
      child: const MovieTimeDetailWidget(),
    );
  }
}
