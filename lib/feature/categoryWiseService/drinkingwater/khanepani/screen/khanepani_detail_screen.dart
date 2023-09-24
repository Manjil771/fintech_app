import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/widget/khanepani_detail_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class KhanepaniDetailsPage extends StatelessWidget {
  final UtilityResponseData useServiceResponse;
  final String customerCode;
  final String selectedCounter;
  final ServiceList serivceList;

  const KhanepaniDetailsPage({
    Key? key,
    required this.useServiceResponse,
    required this.customerCode,
    required this.selectedCounter,
    required this.serivceList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhanepaniDetailsWidgets(
      customerCode: customerCode,
      service: serivceList,
      selectedCounter: selectedCounter,
      useServiceResponse: useServiceResponse,
    );
  }
}
