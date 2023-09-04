import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/enum/counters_fetch_enum.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_search_page.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class KuklPaymentWidget extends StatelessWidget {
  final ServiceList service;

  KuklPaymentWidget({Key? key, required this.service}) : super(key: key);
  final TextEditingController _mobileNumberController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          showRecentTransaction: true,
          associatedId: service.id.toString(),
          buttonName: "Show Bill",
          showAccountSelection: true,
          title: service.service,
          detail: service.instructions,
          showDetail: true,
          topbarName: "Khane Pani",
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              final _response;
              NavigationService.push(
                  target: CommonBillDetailPage(
                      body: Column(
                        children: [
                          KeyValueTile(
                            title: "Phone Number",
                            value: _mobileNumberController.text,
                          ),
                          KeyValueTile(
                            title: "Amount",
                            value: _amountController.text,
                          ),
                          // KeyValueTile(
                          //   title: "Address",
                          //   value: _response.findValueString("address"),
                          // ),
                          // KeyValueTile(
                          //   title: "Current Month Dues",
                          //   value: _response
                          //       .findValueString("current_month_dues"),
                          // ),
                          // KeyValueTile(
                          //   title: "Current Fine",
                          //   value: _response
                          //       .findValueString("current_month_fine"),
                          // ),
                          // KeyValueTile(
                          //   title: "Discount",
                          //   value: _response
                          //       .findValueString("current_month_discount"),
                          // ),
                          // KeyValueTile(
                          //   title: "Total Credit Sales Amount",
                          //   value: _response
                          //       .findValueString("total_credit_sales_amount"),
                          // ),
                          // KeyValueTile(
                          //   title: "Total Advance Amount",
                          //   value: _response
                          //       .findValueString("total_advance_amount"),
                          // ),
                          // KeyValueTile(
                          //   title: "Previous Dues",
                          //   value: _response.findValueString("previous_dues"),
                          // ),
                        ],
                      ),
                      accountDetails: {
                        "account_number":
                            RepositoryProvider.of<CustomerDetailRepository>(
                                    context)
                                .selectedAccount
                                .value!
                                .accountNumber,
                        "amount": _amountController.text,
                        "phone_number": _mobileNumberController.text,
                      },
                      apiEndpoint: "/api/topup",
                      apiBody: {},
                      service: service,
                      serviceIdentifier: service.uniqueIdentifier));
            }
          },
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  title: service.labelName,
                  hintText: service.labelPrefix,
                  validator: (val) => FormValidator.validateFieldNotEmpty(
                      val, service.labelName),
                  controller: _mobileNumberController,
                  onTap: () {},
                ),
                CustomTextField(
                  title: "Amount",
                  hintText: "XXXXXXXXX",
                  controller: _amountController,
                  validator: (val) => FormValidator.validateAmount(
                      val: val.toString(),
                      maxAmount: service.maxValue,
                      minAmount: service.minValue),
                ),
              ],
            ),
          )),
    );
  }
}
