import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/receiveMoney/cubits/receive_from_bank_cubit.dart';
import 'package:ismart/feature/receiveMoney/mobileBanking/widgets/mobile_banking_widget.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_from_bank_repository.dart';
import 'package:ismart/feature/sendMoney/anyBank/widgets/any_bank_widget.dart';
import 'package:ismart/feature/sendMoney/cubits/bank_charge_cubit.dart';
import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_repository.dart';

class MobileBankingPage extends StatelessWidget {
  const MobileBankingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReceiveFromBankCubit(
        receiveFromBankRepository:
            RepositoryProvider.of<ReceiveFromBankRepository>(context),
      ),
      child: MobileBankingWidget(),
    );
  }
}
