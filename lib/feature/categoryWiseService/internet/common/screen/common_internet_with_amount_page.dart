import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/internet/common/widget/common_internet_with_amount_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class CommonInternetWithAmountPage extends StatelessWidget {
  final ServiceList service;
  const CommonInternetWithAmountPage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
        utilityPaymentRepository:
            RepositoryProvider.of<UtilityPaymentRepository>(context),
      ),
      child: CommonInternetWithAmountWidget(
        service: service,
      ),
    );
  }
}
