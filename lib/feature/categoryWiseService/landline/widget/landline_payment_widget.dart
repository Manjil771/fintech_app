import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/regex_utils.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/enums/topup_type.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/utils/topup_utils.dart';

import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';

import '../../../dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class LandlinePaymentWidget extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
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

            if (state is CommonStateSuccess) {
              NavigationService.push(
                  target: CommonTransactionSuccessPage(
                transactionID: "",
                body: Column(
                  children: [
                    KeyValueTile(
                        title: "Status", value: state.statusCode.toString())
                  ],
                ),
                message: state.data,
              ));
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
          },
          child: CommonContainer(
            showDetail: true,
            showAccountSelection: true,
            accountTitle: "From Account",
            buttonName: "Proceed",
            topbarName: "Payment",
            title: "LandLine Payment",
            detail: "Pay your Landline Bills.",
            body: Column(
              children: [
                CustomTextField(
                  title: "Landline Number",
                  hintText: "xxxxxxxxxx",
                  controller: _phoneNumberController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Number"),
                ),
                CustomTextField(
                  title: "Amount",
                  hintText: "Enter the amount",
                  controller: _amountController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Amount"),
                ),
              ],
            ),
            onButtonPressed: () {
              NavigationService.push(
                target: TransactionPinScreen(
                  onValueCallback: (mpin) {
                    NavigationService.pop();
                    context.read<UtilityPaymentCubit>().getTopUp(
                          serviceIdentifier: "pstn_online_topup",
                          phoneNumber: _phoneNumberController.text, //14232352
                          amount: _amountController.text,
                          mpin: mpin,
                        );
                  },
                ),
              );
            },
          )),
    );
  }
}
