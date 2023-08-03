import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/amount_utils.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/custom_checkbox.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/internet/worldlink/widgets/worldlink_search_widget.dart';
import 'package:ismart/feature/categoryWiseService/tvPayment/resources/tv_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../../../common/util/size_utils.dart';

class TvPaymentDeatilWidget extends StatefulWidget {
  final String amount;
  final String userName;
  final ServiceList service;
  final TvDetailModel detailFetchData;

  const TvPaymentDeatilWidget(
      {super.key,
      required this.detailFetchData,
      required this.service,
      required this.amount,
      required this.userName});
  @override
  State<TvPaymentDeatilWidget> createState() => _TvPaymentDeatilWidgetState();
}

class _TvPaymentDeatilWidgetState extends State<TvPaymentDeatilWidget> {
  bool _changePackage = false;
  bool _isLoading = false;
  String? testing;
  @override
  Widget build(BuildContext context) {
    final HashResponse hashResponse =
        widget.detailFetchData.details.hashResponse;
    final List<TvPackages> tvPackages =
        widget.detailFetchData.details.tvPackages;

    TvPackages selectedPackage = tvPackages[0];

    String getAmount() {
      if (widget.amount.isEmpty) {
        return selectedPackage.amount ?? "";
      } else {
        return widget.amount;
      }
    }

    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        topbarName: widget.service.serviceCategoryName,
        title: widget.service.service,
        buttonName: 'Proceed',
        detail: widget.service.instructions,
        showAccountSelection: true,
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
              final UtilityResponseData _response = state.data;

              if (_response.code == "M0000") {
                NavigationService.push(
                    target: CommonTransactionSuccessPage(
                        body: Container(),
                        message: _response.message,
                        transactionID: _response.transactionIdentifier));
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Details",
                style: _textTheme.headlineSmall,
              ),
              SizedBox(height: _height * 0.01),
              Column(
                children: [
                  hashResponse.customerName.isEmpty
                      ? Container()
                      : KeyValueTile(
                          title: "Customer Name",
                          value: hashResponse.customerName,
                        ),
                  hashResponse.casId.isEmpty
                      ? Container()
                      : KeyValueTile(
                          title: "Customer ID",
                          value: hashResponse.casId,
                        ),
                  hashResponse.expiryDate.isEmpty
                      ? Container()
                      : KeyValueTile(
                          title: "Expiry Date",
                          value: hashResponse.expiryDate.toString()),
                  hashResponse.balance.isEmpty
                      ? Container()
                      : KeyValueTile(
                          title: "Balance",
                          value: hashResponse.balance,
                        ),
                  KeyValueTile(title: "Amount", value: getAmount()),
                  tvPackages.isEmpty
                      ? Container()
                      : CustomCheckbox(
                          leftMargin: CustomTheme.symmetricHozPadding,
                          selected: _changePackage,
                          onChanged: (val) {
                            setState(() {
                              _changePackage = !_changePackage;
                            });
                          },
                          title: "Change Package",
                        ),
                  Text(testing.toString()),
                  _changePackage == true
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 50.hp,
                          width: double.infinity,
                          child: CustomTextField(
                            readOnly: true,
                            trailing: DropdownButton<TvPackages>(
                              underline: const SizedBox(),
                              onChanged: (TvPackages? value) {
                                if (value != null) {
                                  selectedPackage = value;
                                  getAmount();
                                  testing = value.text;
                                  setState(() {});

                                  print(selectedPackage.text);
                                }
                              },
                              items:
                                  tvPackages.map<DropdownMenuItem<TvPackages>>(
                                (TvPackages option) {
                                  return DropdownMenuItem<TvPackages>(
                                    value: option,
                                    child: Text(
                                      option.text ?? "",
                                      style: _textTheme.titleSmall,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ),
        onButtonPressed: () {
          // serviceIdentifier: widget.service.uniqueIdentifier,
          //       apiEndpoint: "/api/tvpay",
          //       apiBody: {
          //         "customer_id ": customerIDController.text,
          //         "username": customerIDController.text,
          //       },
          //       accountDetails: {
          //         "account_number":
          //             RepositoryProvider.of<CustomerDetailRepository>(context)
          //                 .selectedAccount
          //                 .value!
          //                 .accountNumber
          //                 .toString(),
          //         "username": customerIDController.text,
          //         "customer_id ": customerIDController.text,
          //         "amount": amountController.text,
          //       },
          // final packageID = _selectedPackageId.isEmpty
          //     ? _defaultID.first["id"]
          //     : _selectedPackageId.toString();

          // final boody = {
          //   "packageId": packageID,
          //   "Reserve Info": widget.detailFetchData
          //       .findValue(
          //           primaryKey: "hashResponse", secondaryKey: "Reserve Info")
          //       .toString(),
          //   "Result Message": widget.detailFetchData
          //       .findValue(
          //           primaryKey: "hashResponse", secondaryKey: "Result Message")
          //       .toString(),
          //   "subscribedPackageName": _packageController.text.isEmpty
          //       ? widget.detailFetchData
          //           .findValue(
          //               primaryKey: "hashResponse",
          //               secondaryKey: "subscribedPackageName")
          //           .toString()
          //       : _packageController.text,
          //   "paymentMessage": widget.detailFetchData
          //       .findValue(
          //           primaryKey: "hashResponse", secondaryKey: "paymentMessage")
          //       .toString(),
          //   "dueAmount": widget.detailFetchData
          //       .findValue(
          //           primaryKey: "hashResponse", secondaryKey: "dueAmount")
          //       .toString(),
          //   // "Amount": _amountController.text.isEmpty
          //   //     ? widget.detailFetchData
          //   //         .findValue(
          //   //             primaryKey: "hashResponse", secondaryKey: "Amount")
          //   //         .toString()
          //   //     : _amountController.text,
          //   "isNew": widget.detailFetchData
          //       .findValue(primaryKey: "hashResponse", secondaryKey: "isNew")
          //       .toString(),
          //   "sessionId": widget.detailFetchData
          //       .findValue(
          //           primaryKey: "hashResponse", secondaryKey: "sessionId")
          //       .toString(),
          //   "customerName": widget.detailFetchData
          //       .findValue(
          //           primaryKey: "hashResponse", secondaryKey: "customerName")
          //       .toString(),
          //   "subscribedPackageType": widget.detailFetchData
          //       .findValue(
          //           primaryKey: "hashResponse",
          //           secondaryKey: "subscribedPackageType")
          //       .toString(),
          //   "status": widget.detailFetchData
          //       .findValue(primaryKey: "hashResponse", secondaryKey: "status")
          //       .toString(),
          // };
        },
      ),
    );
  }
}
