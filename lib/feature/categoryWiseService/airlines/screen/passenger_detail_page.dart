import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/passenger_detail_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class PassengerDetailScreen extends StatelessWidget {
  Availability? departureFlight;
  final UtilityResponseData utilityResponseData;
  Availability? arrivalFlight;

  final double totalFare;
  final ServiceList service;

  PassengerDetailScreen(
      {super.key,
      required this.adultCount,
      required this.childrenCount,
      required this.departureFlight,
      this.arrivalFlight,
      required this.service,
      required this.totalFare,
      required this.utilityResponseData});
  final adultCount;
  final childrenCount;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UtilityPaymentCubit(
              utilityPaymentRepository:
                  RepositoryProvider.of<UtilityPaymentRepository>(context)),
        )
      ],
      child: PassengerDetailWidget(
        responseData: utilityResponseData,
        totalFare: totalFare,
        service: service,
        adultCount: adultCount,
        departureFlight: departureFlight,
        arrivalFlight: arrivalFlight,
        childrenCount: childrenCount,
      ),
    );
  }
}
