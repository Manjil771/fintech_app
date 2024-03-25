import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/feature/banking/loan/loanStatement/widget/loan_statement_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class LoanStatementPage extends StatefulWidget {
  @override
  State<LoanStatementPage> createState() => _LoanStatementPageState();
}

class _LoanStatementPageState extends State<LoanStatementPage> {
  Future<String> getMpin() async {
    final String mPin = await SecureStorageService.appPassword;
    return mPin;
  }

  @override
  void initState() {
    getMpin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: LoanStatementWidget(),
    );
  }
}
