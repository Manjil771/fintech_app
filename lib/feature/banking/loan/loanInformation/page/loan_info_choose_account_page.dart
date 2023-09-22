import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/banking/loan/loanInformation/widget/loan_info_choose_account_widget.dart';
import 'package:ismart/feature/banking/loan/loanSchedule/widget/loan_schedule_choose_account_widget.dart';
import 'package:ismart/feature/banking/loan/loanStatement/widget/loan_statement_choose_account_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';

class LoanInfoChooseAccountPage extends StatelessWidget {
  const LoanInfoChooseAccountPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository: RepositoryProvider.of(context)),
      child: LoanInfoChooseAccountWidget(),
    );
  }
}
