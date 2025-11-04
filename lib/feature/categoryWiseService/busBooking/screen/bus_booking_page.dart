import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_booking_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class BusBookingPage extends StatelessWidget {
  final ServiceList service;

  const BusBookingPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UtilityPaymentCubit(
            utilityPaymentRepository:
                RepositoryProvider.of<UtilityPaymentRepository>(context)),
        child: BusBookingWidget(
          service: service,
        ));
  }
}
