import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_amount_box.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class RidePaymentWidget extends StatefulWidget {
  final ServiceList service;
  RidePaymentWidget({Key? key, required this.service}) : super(key: key);

  @override
  State<RidePaymentWidget> createState() => _RidePaymentWidgetState();
}

class _RidePaymentWidgetState extends State<RidePaymentWidget> {
  final TextEditingController amountController = TextEditingController();

  final TextEditingController riderIDController = TextEditingController();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController remarksController =
        TextEditingController(text: "${widget.service.service} ride payment");
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
            UtilityResponseData _response = state.data;
            if (_response.details == "M0000" ||
                _response.status.toLowerCase() == "success") {
              if (_response.findValue(primaryKey: "exists").toString() ==
                  "true") {
                NavigationService.push(
                    target: CommonBillDetailPage(
                        body: Column(
                          children: [
                            KeyValueTile(
                                title: "Rider Id",
                                value: riderIDController.text),
                            KeyValueTile(
                                title: "Amount", value: amountController.text),
                            KeyValueTile(
                                title: "Remarks",
                                value: remarksController.text),
                          ],
                        ),
                        accountDetails: {},
                        apiEndpoint: "/api/pathao/payment",
                        apiBody: {
                          "accountNo":
                              RepositoryProvider.of<CustomerDetailRepository>(
                                      context)
                                  .selectedAccount
                                  .value!
                                  .accountNumber,
                          "amount": amountController.text,
                          "mobileNo": riderIDController.text,
                          "remarks": remarksController.text,
                        },
                        service: widget.service,
                        serviceIdentifier: widget.service.uniqueIdentifier));
              } else {
                showPopUpDialog(
                    context: context,
                    message: "Rider ID doesnot exist.",
                    title: "Failure",
                    buttonCallback: () {
                      NavigationService.pop();
                    },
                    showCancelButton: false);
              }
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
            onButtonPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<UtilityPaymentCubit>().fetchDetails(
                    serviceIdentifier: widget.service.uniqueIdentifier,
                    accountDetails: {
                      "mobileNo": riderIDController.text,
                    },
                    apiEndpoint: "/api/pathao/validate");
              }
            },
            detail: widget.service.instructions,
            title: widget.service.service,
            showAccountSelection: true,
            buttonName: "Proceed",
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: "Rider Id",
                    hintText: widget.service.labelSample,
                    controller: riderIDController,
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "rider ID"),
                  ),
                  CommonAmountBox(
                    onChanged: (value) {
                      amountController.text = value;
                      setState(() {});
                    },
                    service: widget.service,
                    textController: amountController,
                  ),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    title: "Remarks",
                    controller: remarksController,
                    hintText: "remarks",
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Remarks"),
                  ),
                ],
              ),
            ),
            topbarName: "Ride Payment"),
      ),
    );
  }
}
