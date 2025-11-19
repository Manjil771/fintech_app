import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/cubit/receive_money_cubit.dart';
import 'package:ismart/feature/receiveMoney/mobileBanking/widgets/receive_money_bank_list_widget.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_money_repository.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class ReceiveMoneyBankListScreen extends StatelessWidget {
  const ReceiveMoneyBankListScreen({
    Key? key,
    required this.onBankSelected,
    this.type = "ismarts",
  }) : super(key: key);
  final Function(Bank) onBankSelected;

  final String type;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceiveMoneyCubit(
        receiveMoneyRepository:
            RepositoryProvider.of<ReceiveMoneyRepository>(context),
      ),
      child: ReceiveMoneyBanksListWidget(
        onBankSelected: onBankSelected,
        type: type,
      ),
    );
  }
}
