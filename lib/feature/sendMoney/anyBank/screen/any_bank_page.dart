import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/sendMoney/anyBank/widgets/any_bank_widget.dart';
import 'package:ismart/feature/sendMoney/cubits/bank_charge_cubit.dart';
import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_repository.dart';

class AnyBankpage extends StatelessWidget {
  final String? remarks;
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? bankName;

  const AnyBankpage(
      {Key? key,
      this.accountNumber,
      this.accountName,
      this.bankCode,
      this.bankName,
      this.remarks})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BankChargeCubit(
            sendToBankRepository:
                RepositoryProvider.of<SendToBankRepository>(context),
          ),
        ),
        BlocProvider(
          create: (_) => SendToBankCubit(
            sendToBankRepository:
                RepositoryProvider.of<SendToBankRepository>(context),
          ),
        ),
      ],
      child: AnyBankWidget(
        remarks: remarks,
        accountName: accountName,
        accountNumber: accountNumber,
        bankCode: bankCode,
        bankName: bankName,
      ),
    );
  }
}
