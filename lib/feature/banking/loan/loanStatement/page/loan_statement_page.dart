import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/banking/loan/loanStatement/widget/loan_statement_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class LoanStatementPage extends StatelessWidget {
  final String mPin;
  final UtilityResponseData response;
  const LoanStatementPage(
      {Key? key, required this.response, required this.mPin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context))
        ..fetchDetails(
            serviceIdentifier: "",
            accountDetails: {
              "accountNumber":
                  RepositoryProvider.of<CustomerDetailRepository>(context)
                      .selectedAccount
                      .value!
                      .accountNumber,
              "mPin": mPin,
            },
            apiEndpoint: "/api/loan/details"),
      child: LoanStatementWidget(
        response: response,
      ),
    );
  }
}
