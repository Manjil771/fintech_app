import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
import 'package:ismart/feature/dashboard/homePage/widget/homepage_money_widget.dart';

class HomePageMoneyPage extends StatelessWidget {
  const HomePageMoneyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppServiceCubit(
          appServiceRepository:
              RepositoryProvider.of<AppServiceRepository>(context))
        ..fetchAppService(),
      child: const HomePageMoneyWidget(),
    );
  }
}
