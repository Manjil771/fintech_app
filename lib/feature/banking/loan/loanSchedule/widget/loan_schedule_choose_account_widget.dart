import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/banking/loan/loanSchedule/page/loan_schedule_page.dart';
import 'package:ismart/feature/banking/loan/loanStatement/page/loan_statement_page.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LoanScheduleChooseAccountWidget extends StatefulWidget {
  LoanScheduleChooseAccountWidget({Key? key}) : super(key: key);

  @override
  State<LoanScheduleChooseAccountWidget> createState() =>
      _LoanScheduleChooseAccountWidgetState();
}

class _LoanScheduleChooseAccountWidgetState
    extends State<LoanScheduleChooseAccountWidget> {
  bool _isLoading = false;

  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  String? userPin;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    Future getMpin() async {
      final String mPin = await SecureStorageService.appPassword;
      if (mPin.isNotEmpty) {
        userPin = mPin;
        context.read<UtilityPaymentCubit>().fetchDetails(
            serviceIdentifier: "",
            accountDetails: {
              "accountNumber":
                  RepositoryProvider.of<CustomerDetailRepository>(context)
                      .selectedAccount
                      .value!
                      .accountNumber,
              "mPin": mPin
            },
            apiEndpoint: "/api/loan/schedule");
      }
    }

    return PageWrapper(
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }
          if (state is CommonError) {
            showPopUpDialog(
              context: context,
              message: state.message,
              title: "Error",
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            final _response = state.data;
            if (_response.code == "M0000") {
              NavigationService.pushReplacement(
                  target: LoanSchedulePage(
                mpin: userPin.toString(),
                response: _response,
              ));
            } else {
              showPopUpDialog(
                  context: context,
                  message: _response.message,
                  title: "Error",
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                  showCancelButton: false);
            }
          }
        },
        child: CommonContainer(
          buttonName: "Proceed",
          showAccountSelection: true,
          title: "Select Account",
          body: Container(),
          onButtonPressed: () {
            getMpin();
          },
          topbarName: "Loan Schedule",
        ),
      ),
    );
  }
}
