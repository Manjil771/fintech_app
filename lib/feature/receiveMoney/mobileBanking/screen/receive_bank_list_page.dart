import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/receiveMoney/cubits/receive_from_bank_cubit.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_from_bank_repository.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/bank_list_page.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class ReceiveBankListPage extends StatelessWidget {
  const ReceiveBankListPage({Key? key, required this.onBankSelected})
      : super(key: key);
  final Function(Bank) onBankSelected;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReceiveFromBankCubit(
            receiveFromBankRepository:
                RepositoryProvider.of<ReceiveFromBankRepository>(context),
          ),
        ),
      ],
      child: BankListPage(
        onBankSelected: onBankSelected,
      ),
    );
  }
}
