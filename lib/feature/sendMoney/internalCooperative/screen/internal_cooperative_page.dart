import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/cubits/internal_transfer_cubit.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/resources/internal_transfer_repository.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/widget/internal_cooperative_widget.dart';

class InternalCooperativePage extends StatelessWidget {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? branchCode;

  const InternalCooperativePage(
      {Key? key,
      this.accountNumber,
      this.accountName,
      this.bankCode,
      this.branchCode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => InternalTransferCubit(
        internalTransferRepository:
            RepositoryProvider.of<InternalTransferRepository>(context),
      ),
      child: InternalCooperativeWidget(
        accountName: accountName,
        accountNumber: accountNumber,
        bankCode: bankCode,
        branchCode: branchCode,
      ),
    );
  }
}
