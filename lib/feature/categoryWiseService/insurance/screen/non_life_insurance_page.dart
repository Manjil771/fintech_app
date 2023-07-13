import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/insurance/widget/non_life_insurance_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

import '../../../dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class CommonInsurancePage extends StatelessWidget {
  final ServiceList service;

  const CommonInsurancePage({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
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
