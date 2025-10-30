import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
import 'package:ismart/feature/receiveMoney/widget/receive_money_widget.dart';

import '../../appServiceManagement/cubit/app_service_cubit.dart';

class ReceiveMoneyPage extends StatelessWidget {
  const ReceiveMoneyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppServiceCubit(
        appServiceRepository:
            RepositoryProvider.of<AppServiceRepository>(context),
      ),
      child: const ReceiveMoneyWidget(),
    );
  }
}
