import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/cubit/cerdit_card_cubit.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_bank_model.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/screen/credit_card_bank_list_page.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

import '../../../../common/widget/common_text_field.dart';

class CreditCardPaymentWidget extends StatefulWidget {
  final ServiceList service;
  const CreditCardPaymentWidget({Key? key, required this.service})
      : super(key: key);

  @override
  State<CreditCardPaymentWidget> createState() =>
      _CreditCardPaymentWidgetState();
}

class _CreditCardPaymentWidgetState extends State<CreditCardPaymentWidget> {
  final TextEditingController _selectedBankController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CreditCardBankList? selectedBank;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: BlocListener<CreditCardCubit, CommonState>(
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
            if (state is CommonStateSuccess<String>) {
              final _response = state.data;

              NavigationService.push(
                  target: CommonBillDetailPage(
                      serviceName: widget.service.service,
                      body: Column(
                        children: [
                          KeyValueTile(
                              title: "Bank Name",
                              value: selectedBank!.bankName),
                          KeyValueTile(
                              title: "Card Number",
                              value: _cardNumberController.text),
                          KeyValueTile(
                              title: "Charge", value: _response.toString()),
                          KeyValueTile(
                              title: "Amount", value: _amountController.text),
                        ],
                      ),
                      accountDetails: const {},
                      apiEndpoint: "/api/credit_card/payment",
                      apiBody: {
                        "accountNumber":
                            RepositoryProvider.of<CustomerDetailRepository>(
                                    context)
                                .selectedAccount
                                .value!
                                .accountNumber,
                        "creditCardNumber": _cardNumberController.text,
                        "bankCode": selectedBank!.bankCode,
                        "cardHolderName": _customerNameController.text,
                        "remarks": _remarksController.text,
                        "amount": _amountController.text,
                        "charge": _response.toString(),
                      },
                      service: widget.service,
                      serviceIdentifier: ""));
              // } else {
              //   showPopUpDialog(
              //     context: context,
              //     message: _response.message,
              //     title: "Error",
              //     showCancelButton: false,
              //     buttonCallback: () {
              //       NavigationService.pop();
              //     },
              //   );
              // }
            }
          },
          child: CommonContainer(
            buttonName: "Procced",
            title: widget.service.service,
            detail: widget.service.instructions,
            showAccountSelection: true,
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: "Select Bank",
                    title: "Select Bank",
                    readOnly: true,
                    controller: _selectedBankController,
                    onTap: () {
                      NavigationService.push(
                        target: CreditCardBankListPage(
                          onBankSelected: (val) {
                            NavigationService.pop();

                            _selectedBankController.text = val.bankName;
                            selectedBank = val;
                            setState(() {});
                          },
                        ),
                      );
                    },
                    validator: (value) {
                      if (selectedBank != null) {
                        return null;
                      } else {
                        return "Please select destination bank.";
                      }
                    },
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _cardNumberController,
                    title: "Card Number",
                    hintText: "XXXXXXXX",
                    validator: (value) => FormValidator.validateFieldNotEmpty(
                        value, "Card Number"),
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _customerNameController,
                    title: "Card Holder Name",
                    hintText: "XXXXXXXX",
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Name"),
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputType: TextInputType.number,
                    controller: _amountController,
                    title: "Amount",
                    hintText: "NPR",
                    validator: (value) => FormValidator.validateAmount(
                      val: value.toString(),
                      maxAmount: widget.service.maxValue,
                      minAmount: widget.service.minValue,
                    ),
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _remarksController,
                    title: "Remarks",
                    hintText: "Remarks",
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Remarks"),
                  ),
                ],
              ),
            ),
            showDetail: true,
            topbarName: widget.service.serviceCategoryName,
            onButtonPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<CreditCardCubit>().fetchCharge(
                      amount: _amountController.text,
                      bankId: selectedBank?.bankCode ?? "",
                    );
              }
            },
          )),
    );
  }
}
