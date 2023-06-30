import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/insurance/nepalLifeInsurance/widget/nepal_life_insurance_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class NepalLifeInsurancePage extends StatelessWidget {
  final String companyName;
  final String companyLogo;
  final Service service;

  const NepalLifeInsurancePage(
      {Key? key,
      required this.companyName,
      required this.companyLogo,
      required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
        utilityPaymentRepository:
            RepositoryProvider.of<UtilityPaymentRepository>(context),
      ),
      child: NepalLifeInsurcnceWidget(
        companyLogo: companyLogo,
        companyName: companyName,
        service: service,
      ),
    );
  }
}
