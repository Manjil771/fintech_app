import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/cubit/khalti_txn_confirm_cubit.dart';
import 'package:ismart/feature/receiveMoney/cubit/receive_money_cubit.dart';
import 'package:ismart/feature/receiveMoney/load_from_khalti/widget/load_from_khalti_widget.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_money_repository.dart';

class LoadFromKhaltiPage extends StatelessWidget {
  const LoadFromKhaltiPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReceiveMoneyCubit(
            receiveMoneyRepository:
                RepositoryProvider.of<ReceiveMoneyRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => KhaltiTxnConfirmCubit(
            receiveMoneyRepository:
                RepositoryProvider.of<ReceiveMoneyRepository>(context),
          ),
        ),
      ],
      child: const LoadFromKhaltiWidget(),
    );
  }
}
