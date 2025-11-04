import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/cubit/cerdit_card_cubit.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_repository.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/widget/credit_card_payment_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class CreditCardPaymentPage extends StatelessWidget {
  final ServiceList service;
  const CreditCardPaymentPage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UtilityPaymentCubit(
              utilityPaymentRepository:
                  RepositoryProvider.of<UtilityPaymentRepository>(context)),
        ),
        BlocProvider(
          create: (context) => CreditCardCubit(
              creditCardRepository:
                  RepositoryProvider.of<CreditCardRepository>(context)),
        ),
      ],
      child: CreditCardPaymentWidget(
        service: service,
      ),
    );
  }
}
