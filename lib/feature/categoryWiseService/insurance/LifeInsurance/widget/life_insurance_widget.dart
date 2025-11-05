import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/date_formater.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
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

class LifeInsurcnceWidget extends StatefulWidget {
  final ServiceList service;

  const LifeInsurcnceWidget({super.key, required this.service});

  @override
  State<LifeInsurcnceWidget> createState() => _LifeInsurcnceWidgetState();
}

class _LifeInsurcnceWidgetState extends State<LifeInsurcnceWidget> {
  TextEditingController selectedDateController = TextEditingController();
  TextEditingController policyNoController = TextEditingController();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: BlocListener<UtilityPaymentCubit, CommonState>(
      listener: (context, state) {
        print(state);
        if (state is CommonLoading && _isLoading == false) {
          _isLoading = true;
          showLoadingDialogBox(context);
        } else if (state is! CommonLoading && _isLoading) {
          _isLoading = false;
          NavigationService.pop();
        }

        if (state is CommonStateSuccess<UtilityResponseData>) {
          final UtilityResponseData _response = state.data;
          if (_response.code == "M0000") {
            NavigationService.push(
              target: CommonBillDetailPage(
                serviceName: widget.service.service,
                serviceIdentifier: widget.service.uniqueIdentifier,
                service: widget.service,
                apiEndpoint: "/api/insurance/pay",
                apiBody: {
                  "policyNo": _response.findValue(
                    primaryKey: "hashResponse",
                    secondaryKey: "policyNo",
                  ),
                  "policyName": _response.findValue(
                    primaryKey: "hashResponse",
                    secondaryKey: "policyName",
                  ),

                  // "IsNepDob": false,
                  // "isNepDob": false,
                  // "is_nep_dob": false,
                },
                accountDetails: {
                  "sessionId": _response
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "sessionId",
                      )
                      .toString(),
                  "account_number":
                      RepositoryProvider.of<CustomerDetailRepository>(context)
                          .selectedAccount
                          .value!
                          .accountNumber,
                  "amount": _response.findValue(
                      primaryKey: "hashResponse", secondaryKey: "amount"),
                  "dob": selectedDateController.text,
                },
                body: Column(
                  children: [
                    KeyValueTile(
                      title: "Username",
                      value: (() {
                        final policyName = _response.findValue(
                          primaryKey: "hashResponse",
                          secondaryKey: "policyName",
                        );
                        if (policyName != null &&
                            policyName.toString().isNotEmpty) {
                          return policyName.toString();
                        }

                        final customerName = _response.findValue(
                          primaryKey: "hashResponse",
                          secondaryKey: "customerName",
                        );
                        if (customerName != null &&
                            customerName.toString().isNotEmpty) {
                          return customerName.toString();
                        }

                        return "";
                      })(),
                    ),
                    checkEmptyCase(
                      title: "Address",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "address",
                          )
                          .toString(),
                    ),
                    KeyValueTile(
                      title: "Policy Number",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "policyNo",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Payment Mode",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "paymentMode",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Session Id",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "sessionId",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Product Name",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "productName",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Customer Id",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "customerId",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Premium",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "premium",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Due Date",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "dueDate",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Invoice Number",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "invoiceNumber",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Due Date",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "nextDueDate",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Amount",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "amount",
                          )
                          .toString(),
                    ),
                    checkEmptyCase(
                      title: "Penalty",
                      value: _response
                          .findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "interestOccured",
                          )
                          .toString(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            showPopUpDialog(
                context: context,
                message: _response.message,
                title: "Error".tr(),
                buttonCallback: () {
                  NavigationService.pop();
                },
                showCancelButton: false);
          }
        } else if (state is CommonError) {
          showPopUpDialog(
            context: context,
            message: state.message,
            title: "Error".tr(),
            showCancelButton: false,
            buttonCallback: () {
              NavigationService.pop();
            },
          );
        }
      },
      child: CommonContainer(
        title: widget.service.service.tr(),
        detail: widget.service.instructions.tr(),
        // detail: "Pay for your Insurance premium from here.",
        showDetail: true,
        showAccountSelection: true,
        topbarName: widget.service.serviceCategoryName,
        buttonName: "Show Details".tr(),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        height: _height * 0.11,
                        width: _width * 0.23,
                        margin: const EdgeInsets.only(right: 18),
                        child: Image.network(
                            "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.service.icon}"),
                      ),
                      Expanded(
                        child: Text(widget.service.service,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  SizedBox(height: _height * 0.02),
                  // Text(
                  //   "From Account",
                  //   style: const TextStyle(
                  //     fontFamily: Fonts.poppin,
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 13,
                  //     color: CustomTheme.lightTextColor,
                  //   ),
                  // ),
                  // PrimaryAccountBox(),
                  CustomTextField(
                    title: widget.service.labelName,
                    hintText: "Policy NO",
                    controller: policyNoController,
                    validator: (value) => FormValidator.validateFieldNotEmpty(
                        value, "Policy No."),
                  ),
                  SizedBox(height: _height * 0.01),
                  CustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Select Date";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                      LengthLimitingTextInputFormatter(10),
                      DateFormatter()
                    ],
                    onTap: () async {
                      final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1905),
                          lastDate: DateTime.now());
                      setState(
                        () {
                          selectedDateController.text =
                              "${date!.year}-${date.month}-${date.day}";
                        },
                      );
                    },
                    readOnly: true,
                    title: "Date of Birth",
                    hintText: "yyyy-mm-dd",
                    controller: selectedDateController,
                    trailing: SvgPicture.asset(
                      Assets.calanderIcon,
                      height: 40.hp,
                      colorFilter: const ColorFilter.mode(
                          Colors.black54, BlendMode.srcIn),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        onButtonPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<UtilityPaymentCubit>().fetchDetails(
                  serviceIdentifier: widget.service.uniqueIdentifier,
                  accountDetails: {
                    // "username": "108006674",
                    "username": policyNoController.text,
                    "dob": selectedDateController.text,
                    // "dob": "1983-07-24",
                  },
                  apiEndpoint: "api/insurance/policy",
                );
          }
        },
      ),
    ));
  }

  checkEmptyCase({required String title, required String value}) {
    if (value.isNotEmpty) {
      return KeyValueTile(title: title, value: value);
    } else {
      return Container();
    }
  }
}
