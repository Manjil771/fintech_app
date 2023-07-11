import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../../dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class IrdPaymentWidget extends StatefulWidget {
  const IrdPaymentWidget({super.key, required this.service});

  final Service service;

  @override
  State<IrdPaymentWidget> createState() => _IrdPaymentWidgetState();
}

class _IrdPaymentWidgetState extends State<IrdPaymentWidget> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _ebpNumberController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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

          if (state is CommonStateSuccess<UtilityResponseData>) {
            UtilityResponseData _response = state.data;
            if (_response.code == "M0000") {
              NavigationService.push(
                  target: CommonBillDetailPage(
                service: widget.service,
                serviceIdentifier: widget.service.uniqueIdentifier,
                accountDetails: {
                  'amount': _amountController.text,
                  'account_number':
                      RepositoryProvider.of<CustomerDetailRepository>(context)
                          .selectedAccount
                          .value!
                          .accountNumber,
                },
                apiBody: {
                  "voucherCode": _ebpNumberController.text,
                  "billerCode": _response.findValue(
                    primaryKey: "hashResponse",
                    secondaryKey: "billerCode",
                  ),
                  "serviceCharge": _response.findValue(
                    primaryKey: "hashResponse",
                    secondaryKey: "serviceCharge",
                  ),
                },
                apiEndpoint: '/api/governmentpayment/pay',
                body: Column(
                  children: [
                    KeyValueTile(
                        title: "Biller Code",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "billerCode",
                            )
                            .toString()),
                    KeyValueTile(
                        title: "Customer Name",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "customerName",
                            )
                            .toString()),
                    KeyValueTile(
                        title: "Amount",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "amount",
                            )
                            .toString()),
                    KeyValueTile(
                        title: "Service Charge",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "serviceCharge",
                            )
                            .toString()),
                    KeyValueTile(
                        title: "Total Amount",
                        value: _response
                            .findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "totalAmount",
                            )
                            .toString()),
                  ],
                ),
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
          topbarName: 'Payment',
          title: 'Revenue payment',
          detail: 'Enter the required details to proceed further',
          showDetail: true,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _ebpNumberController,
                  title: 'EBP Number/Request Code',
                  hintText: 'XXXX-XXXXX',
                  validator: (value) =>
                      FormValidator.validateFieldNotEmpty(value, 'EBP Number'),
                ),
                CustomTextField(
                  validator: (value) =>
                      FormValidator.validateFieldNotEmpty(value, 'Amount'),
                  controller: _amountController,
                  textInputType: TextInputType.number,
                  title: 'Amount',
                  hintText: 'Enter the amount',
                ),
              ],
            ),
          ),
          buttonName: 'Get details',
          onButtonPressed: () {
            _formKey.currentState!.save();
            if (_formKey.currentState!.validate()) {
              context.read<UtilityPaymentCubit>().fetchDetails(
                  serviceIdentifier: widget.service.uniqueIdentifier,
                  accountDetails: {
                    'voucherCode': _ebpNumberController.text, // '2077-4623757',
                    'amount': _amountController.text
                  },
                  apiEndpoint: '/api/governmentpayment/revenueDetail');
            }
          },
        ),
      ),
    );
  }
}
