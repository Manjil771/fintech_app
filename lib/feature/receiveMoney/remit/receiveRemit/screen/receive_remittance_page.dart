import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/receive_remittance_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class ReceiveRemittancePage extends StatelessWidget {
  final CategoryList categoryList;
  const ReceiveRemittancePage({Key? key, required this.categoryList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context))
        ..fetchDetails(
            serviceIdentifier: "",
            accountDetails: {},
            apiEndpoint: "api/remittance/list"),
      child: ReceiveRemittanceWidget(
        categoryList: categoryList,
      ),
    );
  }
}
