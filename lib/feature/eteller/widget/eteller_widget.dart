import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

// ignore: must_be_immutable
class EtellerWidget extends StatefulWidget {
  final String payload;
  EtellerWidget({Key? key, required this.payload}) : super(key: key);

  @override
  State<EtellerWidget> createState() => _EtellerWidgetState();
}

class _EtellerWidgetState extends State<EtellerWidget> {
  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _remarksController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String _currentAmount = '';
    final jsonData = jsonDecode(widget.payload);

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
            final res = state.data;
            if (res.code == "M0000" && res.status.toLowerCase() == "success") {
              NavigationService.pushReplacement(
                  target: CommonTransactionSuccessPage(
                      serviceName: "QR Payment",
                      body: Column(children: [
                        KeyValueTile(
                            title: LocaleKeys.fromaccount.tr(), 
                            value:
                                RepositoryProvider.of<CustomerDetailRepository>(
                                        context)
                                    .selectedAccount
                                    .value!
                                    .accountNumber),
                        KeyValueTile(
                            title: "Merchant Code", value: jsonData["code"]),
                        KeyValueTile(
                            title: "Mobile Number",
                            value: jsonData["mobileNumber"]),
                        KeyValueTile(
                            title: "Amount", value: _amountController.text),
                      ]),
                      message: state.data.message,
                      transactionID: state.data.transactionIdentifier));
            } else {
              showPopUpDialog(
                context: context,
                message: res.message,
                title: "Message",
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          }
        },
        child: CommonContainer(
            verificationAmount: _currentAmount,
            onButtonPressed: () {
              if (_formKey.currentState!.validate()) {
                NavigationService.push(
                    target: TransactionPinScreen(onValueCallback: (p0) {
                  NavigationService.pop();
                  context.read<UtilityPaymentCubit>().makePayment(
                      serviceIdentifier: "",
                      accountDetails: {},
                      body: {
                        "merchantCode": jsonData["code"],
                        "accountNumber":
                            RepositoryProvider.of<CustomerDetailRepository>(
                                    context)
                                .selectedAccount
                                .value!
                                .accountNumber,
                        "amount": _amountController.text,
                        "remarks": _remarksController.text
                      },
                      apiEndpoint: "api/qr/pay",
                      mPin: p0);
                }));
              }
            },
            buttonName: "Proceed",
            showAccountSelection: true,
            topbarName: "Eteller",
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    readOnly: true,
                    customHintTextStyle: true,
                    hintText: jsonData["code"],
                    title: "Merchant Code",
                  ),
                  CustomTextField(
                    textInputType: TextInputType.number,
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Amount"),
                    controller: _amountController,
                    onChanged: (value) {
                      setState(() {
                        _currentAmount = value;
                      });
                    },
                    title: "Amount",
                  ),
                  CustomTextField(
                    title: "Remarks",
                    controller: _remarksController,
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Remarks"),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
