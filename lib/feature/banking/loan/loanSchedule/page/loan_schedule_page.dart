import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/banking/loan/loanSchedule/widget/loan_schedule_wiget.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class LoanSchedulePage extends StatefulWidget {
  const LoanSchedulePage({Key? key}) : super(key: key);

  @override
  State<LoanSchedulePage> createState() => _LoanSchedulePageState();
}

class _LoanSchedulePageState extends State<LoanSchedulePage> {
  getMpin() async {
    String mPin = await SecureStorageService.appPassword;
    return mPin;
  }

  @override
  void initState() {
    getMpin();
    super.initState();
  }

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
              // "mPin": getMpin()
            },
            apiEndpoint: ""),
      child: LoanScheduleWidget(),
    );
  }
}
