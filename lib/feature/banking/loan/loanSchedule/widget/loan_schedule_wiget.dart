import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LoanScheduleWidget extends StatelessWidget {
  LoanScheduleWidget({Key? key}) : super(key: key);
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
            topbarName: "Loan Schedule",
            showRoundBotton: false,
            body: BlocBuilder<UtilityPaymentCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonStateSuccess<UtilityResponseData>) {
                  UtilityResponseData _response = state.data;
                  return Container(
                    child:
                        Text(_response.findValue(primaryKey: "scheduleNumber")),
                  );
                } else {
                  return const NoDataScreen(
                    title: "No transactions yet",
                    details: "Make Your First Transfer",
                  );
                }
              },
            )));
  }
}
