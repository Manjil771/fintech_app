import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/cubits/coop_list_cubit.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/cubits/internal_transfer_cubit.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/resources/internal_transfer_repository.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/widget/internal_cooperative_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class InternalCooperativePage extends StatelessWidget {
  final bool? isFavAccount;
  final String? branchName;

  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? branchCode;
  final String? remarks;

  const InternalCooperativePage(
      {Key? key,
      this.accountNumber,
      this.accountName,
      this.bankCode,
      this.branchCode,
      this.remarks,
      this.isFavAccount,
      this.branchName})
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
          create: (context) => UtilityPaymentCubit(
            utilityPaymentRepository:
                RepositoryProvider.of<UtilityPaymentRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => CoopListCubit(
            internalTransferRepository:
                RepositoryProvider.of<InternalTransferRepository>(context)
                  ..getBranchList(),
          ),
        ),
      ],
      child: InternalCooperativeWidget(
        isFavAccount: isFavAccount,
        branchName: branchName,
        remarks: remarks,
        accountName: accountName,
        accountNumber: accountNumber,
        bankCode: bankCode,
        branchCodeQr: branchCode,
      ),
    );
  }
}
