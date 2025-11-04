import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/landline/widget/landline_payment_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class LandlinePaymentPage extends StatelessWidget {
  final CategoryList category;
  const LandlinePaymentPage({
    Key? key,
    required this.category,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UtilityPaymentCubit(
              utilityPaymentRepository:
                  RepositoryProvider.of<UtilityPaymentRepository>(context),
            ),
        child: LandlinePaymentWidget(
          category: category,
        ));
  }
}
