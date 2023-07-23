import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/airlines/cubit/airlines_cubit.dart';
import 'package:ismart/feature/categoryWiseService/airlines/resources/airlines_repository.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/available_flight_widget.dart';

class AvailableFlightScreen extends StatelessWidget {
  const AvailableFlightScreen(
      {super.key, required this.adultCount, required this.childrenCount});
  final adultCount;
  final childrenCount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AirlinesCubit(
          airlinesRepository:
              RepositoryProvider.of<AirlinesRepository>(context)),
      child: AvailableFlightWidget(
        adultCount: adultCount,
        childrenCount: childrenCount,
      ),
    );
  }
}
