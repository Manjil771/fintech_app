import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/banking/loan/loanStatement/widget/loan_statement_choose_account_widget.dart';

class LoanStatementChooseAccountPage extends StatelessWidget {
  const LoanStatementChooseAccountPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => SubjectBloc(),
      child: LoanStatementChooseAccountWidget(),
    );
  }
}
