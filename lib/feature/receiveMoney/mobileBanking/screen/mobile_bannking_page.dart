import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/cubit/receive_money_cubit.dart';
import 'package:ismart/feature/receiveMoney/mobileBanking/widgets/mobile_bannking_widget.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_money_repository.dart';

class MobileBankingPage extends StatelessWidget {
  const MobileBankingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceiveMoneyCubit(
        receiveMoneyRepository:
            RepositoryProvider.of<ReceiveMoneyRepository>(context),
      ),
      child: const MobileBankingWidget(),
    );
  }
}
