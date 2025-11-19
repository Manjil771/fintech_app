import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/insurance/widget/non_life_insurance_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

import '../../../dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class NonLifeInsurancePage extends StatelessWidget {
  final ServiceList service;

  const NonLifeInsurancePage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: NonLifeInsurcnceWidget(
        service: service,
      ),
    );
  }
}
