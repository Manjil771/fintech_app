import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/primary_account_box.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ChequeBlockWidget extends StatelessWidget {
  ChequeBlockWidget({Key? key}) : super(key: key);
  final TextEditingController chequeNumberController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocListener<UtilityPaymentCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoading && _isLoading == false) {
          _isLoading = true;
          showLoadingDialogBox(context);
        } else if (state is! CommonLoading && _isLoading) {
          _isLoading = false;
          NavigationService.pop();
        } else if (state is CommonError) {
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
          UtilityResponseData _response = state.data;
          showPopUpDialog(
            context: context,
            message: _response.message,
            title: _response.status,
            showCancelButton: false,
            buttonCallback: () {
              NavigationService.pop();
            },
          );
        }
      },
      child: Column(
        children: [
          PrimaryAccountBox(),
          CustomTextField(
            controller: chequeNumberController,
            title: "Enter Cheque Number",
            hintText: "XXXXXXXXX",
          ),
          SizedBox(height: _height * 0.02),
          CustomRoundedButtom(
              title: "Confirm",
              onPressed: () {
                NavigationService.push(target: TransactionPinScreen(
                  onValueCallback: (p0) {
                    NavigationService.pop();
                    context.read<UtilityPaymentCubit>().makePayment(
                        serviceIdentifier: "",
                        accountDetails: {},
                        body: {
                          "mPin": p0,
                          "chequeBlockRequest": chequeNumberController.text,
                        },
                        apiEndpoint: "api/chequeblockrequest",
                        mPin: p0);
                  },
                ));
              }),
        ],
      ),
    );
  }
}
