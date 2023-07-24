import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/airlines/cubit/airlines_cubit.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list.dart';
import 'package:ismart/feature/categoryWiseService/airlines/resources/airlines_repository.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/available_flight_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class AvailableFlightScreen extends StatelessWidget {
  final ServiceList service;

  final AvailableFlightModel flightDetail;
  const AvailableFlightScreen(
      {super.key,
      required this.adultCount,
      required this.childrenCount,
      required this.flightDetail,
      required this.service});
  final adultCount;
  final childrenCount;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AirlinesCubit(
              airlinesRepository:
                  RepositoryProvider.of<AirlinesRepository>(context)),
        ),
        BlocProvider(
          create: (context) => UtilityPaymentCubit(
              utilityPaymentRepository:
                  RepositoryProvider.of<UtilityPaymentRepository>(context)),
        ),
      ],
      child: AvailableFlightWidget(
        service: service,
        adultCount: adultCount,
        childrenCount: childrenCount,
        flightDetail: flightDetail,
      ),
    );
  }
}
