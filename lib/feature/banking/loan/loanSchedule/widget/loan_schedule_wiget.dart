import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/banking/loan/loanSchedule/widget/loan_schedule_choose_account_widget.dart';
import 'package:ismart/feature/banking/loan/loanSchedule/widget/loan_schedule_row_widget.dart';
import 'package:ismart/feature/banking/loan/loanStatement/widget/loan_statement_row_widget.dart';
import 'package:ismart/feature/banking/loan/widget/loan_detail_box_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LoanScheduleWidget extends StatefulWidget {
  final UtilityResponseData response;
  LoanScheduleWidget({Key? key, required this.response}) : super(key: key);

  @override
  State<LoanScheduleWidget> createState() => _LoanScheduleWidgetState();
}

class _LoanScheduleWidgetState extends State<LoanScheduleWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    final _response = widget.response.findValue(primaryKey: "data");
    return PageWrapper(
        body: CommonContainer(
            showTitleText: false,
            verticalPadding: 0,
            horizontalPadding: 0,
            topbarName: "Loan Schedule",
            showRoundBotton: false,
            body: Column(
              children: [
                BlocBuilder<UtilityPaymentCubit, CommonState>(
                  builder: (context, state) {
                    if (state is CommonStateSuccess) {
                      final UtilityResponseData loanResponse = state.data;
                      return LoanDetailBoxWidget(
                        loanResponse: loanResponse,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                widget.response.details.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            height: 60.hp,
                            color: _theme.primaryColor.withOpacity(0.05),
                            child: Row(children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                      child: Text(
                                    "SN",
                                    style: _textTheme.headlineSmall!
                                        .copyWith(fontSize: 12),
                                  )),
                                ),
                              ),
                              Flexible(
                                flex: 10,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "Date",
                                          style: _textTheme.headlineSmall!
                                              .copyWith(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Container(
                                        child: Center(
                                          child: Text("Installment",
                                              textAlign: TextAlign.center,
                                              style: _textTheme.headlineSmall!
                                                  .copyWith(fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "Principal",
                                          style: _textTheme.headlineSmall!
                                              .copyWith(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          "Interest",
                                          style: _textTheme.headlineSmall!
                                              .copyWith(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _response.length,
                              itemBuilder: (context, index) {
                                return LoanScheduleRowWidget(
                                  index: index,
                                  responseData: widget.response,
                                );
                              })
                        ],
                      )
                    : Container(),
              ],
            )));
  }
}
