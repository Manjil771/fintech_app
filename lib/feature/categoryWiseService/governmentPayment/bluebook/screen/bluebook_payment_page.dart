import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/bluebook/cubit/bluebook_payment_cubit.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/bluebook/widget/bluebook_payment_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class BlueBookRenewalPage extends StatelessWidget {
  final ServiceList service;
  const BlueBookRenewalPage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UtilityPaymentCubit(
              utilityPaymentRepository:
                  RepositoryProvider.of<UtilityPaymentRepository>(context))
            ..fetchDetails(
                serviceIdentifier: "",
                accountDetails: {},
                apiEndpoint: "api/vehicle/registration/info"),
        ),
        BlocProvider(
            create: (context) => BluebookPaymentCubit(
                utilityPaymentRepository:
                    RepositoryProvider.of<UtilityPaymentRepository>(context))),
      ],
      child: BlueBookRenewalWidget(
        service: service,
      ),
    );
  }
}
