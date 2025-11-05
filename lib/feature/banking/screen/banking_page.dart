import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
import 'package:ismart/feature/banking/widget/banking_widget.dart';

class Bankingpage extends StatelessWidget {
  const Bankingpage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppServiceCubit(
              appServiceRepository:
                  RepositoryProvider.of<AppServiceRepository>(context),
            ),
        child: const BankingWidget());
  }
}
