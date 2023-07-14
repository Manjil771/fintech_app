import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/regex_utils.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
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

import '../../../customerDetail/resource/customer_detail_repository.dart';
import '../../../dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class LandlinePaymentWidget extends StatefulWidget {
  final CategoryList category;

  LandlinePaymentWidget({super.key, required this.category});

  @override
  State<LandlinePaymentWidget> createState() => _LandlinePaymentWidgetState();
}

class _LandlinePaymentWidgetState extends State<LandlinePaymentWidget> {
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  bool _isLoading = false;

  final _fromKey = GlobalKey<FormState>();
  ServiceList getService() {
    final service = widget.category.services.firstWhere(
      (element) => element.uniqueIdentifier.contains("pstn_online_topup"),
    );

    return service;
  }

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
            buttonName: "Proceed",
            topbarName: "Payment",
            title: "LandLine Payment",
            detail: "Pay your Landline Bills.",
            body: Form(
              key: _fromKey,
              child: Column(
                children: [
                  CustomTextField(
                      textInputType: TextInputType.number,
                      title: "Landline Number",
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      hintText: "xxxxxxxxxx",
                      controller: _phoneNumberController,
                      validator: (val) {
                        if (val!.length <= 7) {
                          return "Enter a valid Number";
                        }
                        FormValidator.validateFieldNotEmpty(val, "Number");
                      }),
                  CustomTextField(
                    textInputType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: "Amount",
                    hintText: "Enter the amount",
                    controller: _amountController,
                    validator: (val) => FormValidator.validateAmount(
                        val: val.toString(),
                        maxAmount: getService().maxValue,
                        minAmount: getService().minValue),
                  ),
                ],
              ),
            ),
            onButtonPressed: () {
              if (_fromKey.currentState!.validate()) {
                print(_phoneNumberController.text
                    .substring(_phoneNumberController.text.length - 8));
                NavigationService.push(
                    target: CommonBillDetailPage(
                  serviceIdentifier: "pstn_online_topup",
                  apiBody: {},
                  apiEndpoint: "/api/topup",
                  service: getService(),
                  accountDetails: {
                    "phone_number": _phoneNumberController.text.substring(
                        _phoneNumberController.text.length - 8), //14232352
                    "amount": _amountController.text,
                    "account_number":
                        RepositoryProvider.of<CustomerDetailRepository>(context)
                            .selectedAccount
                            .value!
                            .accountNumber,
                  },
                  body: Column(
                    children: [
                      KeyValueTile(
                          title: "Phone Number",
                          value: _phoneNumberController.text),
                      KeyValueTile(
                          title: "Amount", value: _amountController.text),
                    ],
                  ),
                ));
              }
            },
          )),
    );
  }
}
