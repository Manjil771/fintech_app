import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/amount_utils.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/categoryWiseService/internet/common/widget/common_username_search_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../../../common/util/size_utils.dart';

class CommonInternetPaymentDeatilWidget extends StatefulWidget {
  final UtilityResponseData detailFetchData;
  final ServiceList service;
  const CommonInternetPaymentDeatilWidget(
      {super.key, required this.detailFetchData, required this.service});
  @override
  State<CommonInternetPaymentDeatilWidget> createState() =>
      _CommonInternetPaymentDeatilWidgetState();
}

class _CommonInternetPaymentDeatilWidgetState
    extends State<CommonInternetPaymentDeatilWidget> {
  final TextEditingController _packageController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _changePackage = false;
  final bool _isLoading = false;
  String _selectedPackageId = "";

  double _dueAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dueAmount = double.tryParse(widget.detailFetchData
                .findValue(primaryKey: "due_amount_till_now")
                ?.toString() ??
            "0") ??
        0;
    _amountController.text = ((double.tryParse(widget.detailFetchData.findValue(
                  primaryKey: "hashResponse",
                  secondaryKey: "amount",
                )) ??
                0) +
            _dueAmount)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool _renewOption = widget.detailFetchData
            .findValue<List>(primaryKey: "packages")
            ?.isNotEmpty ??
        false;
    final _packageOptions = List.from((_renewOption
            ? widget.detailFetchData.findValue(primaryKey: "packages")
            : widget.detailFetchData
                .findValue(primaryKey: "package_options")) ??
        []);

    bool _isLoading = false;
    final bool _isPackageAvailable = _packageOptions.isNotEmpty;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    final idd =
        List.from(widget.detailFetchData.findValue(primaryKey: "packages"));
    final _defaultID = idd.where(
      (element) =>
          element["label"] ==
          widget.detailFetchData
              .findValue(
                primaryKey: "hashResponse",
                secondaryKey: "subscribedPackageName",
              )
              .toString(),
    );
    final amount = _selectedPackageId.isEmpty
        ? widget.detailFetchData
                    .findValue(
                        primaryKey: "hashResponse", secondaryKey: "amount")
                    .toString() ==
                "0"
            ? _defaultID.first["amount"]
            : widget.detailFetchData
                .findValue(primaryKey: "hashResponse", secondaryKey: "amount")
                .toString()
        : _amountController.text;
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
            if (_response.status.toLowerCase() == "success" ||
                _response.code == "M0000" ||
                _response.status == "M0000") {
              NavigationService.push(
                  target: CommonTransactionSuccessPage(
                      body: Column(children: [
                        KeyValueTile(
                          title: "Customer Name",
                          value: widget.detailFetchData
                              .findValue(
                                primaryKey: "hashResponse",
                                secondaryKey: "customerName",
                              )
                              .toString(),
                        ),
                        SizedBox(height: _height * 0.008),
                        KeyValueTile(
                          title: "Customer ID",
                          value: widget.detailFetchData.findValue(
                                primaryKey: "hashResponse",
                                secondaryKey: "userName",
                              ) ??
                              widget.detailFetchData
                                  .findValue(
                                      primaryKey: "hashResponse",
                                      secondaryKey: "username")
                                  .toString(),
                        ),
                        SizedBox(height: _height * 0.008),
                        KeyValueTile(
                          title: "Amount",
                          value:
                              "${AmountUtils.getAmountInRupees(amount: _amountController.text)}",
                        ),
                      ]),
                      message: _response.message,
                      transactionID: _response.transactionIdentifier));
            } else {
              showPopUpDialog(
                context: context,
                message: _response.message,
                title: "Error",
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          }
          print("state iaushdasd $state");
        },
        child: CommonContainer(
          showDetail: true,
          topbarName: 'Payment',
          title: 'Internet Payment',
          buttonName: 'Proceed',
          detail: 'Pay your internet bill of you ISP from here',
          showAccountSelection: true,
          body: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Details",
                    style: _textTheme.headlineSmall,
                  ),
                  SizedBox(height: _height * 0.01),
                  KeyValueTile(
                    title: "Customer Name",
                    value: widget.detailFetchData
                        .findValue(
                          primaryKey: "hashResponse",
                          secondaryKey: "customerName",
                        )
                        .toString(),
                  ),
                  SizedBox(height: _height * 0.008),
                  KeyValueTile(
                    title: "Customer ID",
                    value: widget.detailFetchData.findValue(
                          primaryKey: "hashResponse",
                          secondaryKey: "userName",
                        ) ??
                        widget.detailFetchData
                            .findValue(
                                primaryKey: "hashResponse",
                                secondaryKey: "username")
                            .toString(),
                  ),
                  SizedBox(height: _height * 0.008),
                  KeyValueTile(
                    title: "Amount",
                    value:
                        "${AmountUtils.getAmountInRupees(amount: _amountController.text)}",
                  ),
                  SizedBox(height: _height * 0.008),
                  // if (_isPackageAvailable)
                  //   CustomCheckbox(
                  //     leftMargin: CustomTheme.symmetricHozPadding,
                  //     selected: _changePackage,
                  //     onChanged: (val) {
                  //       setState(() {
                  //         _changePackage = val;
                  //       });
                  //     },
                  //     title: "Change Package",
                  //   ),
                  SizedBox(height: _height * 0.02),
                  if (_isPackageAvailable)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          axis: Axis.vertical,
                          child: child,
                        );
                      },
                      child: OpenContainer(
                        closedColor: Colors.transparent,
                        closedElevation: 0.0,
                        openElevation: 0,
                        transitionType: ContainerTransitionType.fade,
                        closedBuilder: (context, open) {
                          return CustomTextField(
                            margin: const EdgeInsets.only(
                              left: CustomTheme.symmetricHozPadding,
                              right: CustomTheme.symmetricHozPadding,
                            ),
                            controller: _packageController,
                            title: "",
                            hintText: "Renew Options",
                            showSearchIcon: true,
                            readOnly: true,
                            required: true,
                            suffixIcon: Icons.keyboard_arrow_down_rounded,
                            onTap: open,
                            validator: (val) {
                              return FormValidator.validateFieldNotEmpty(
                                val,
                                "Renew Options",
                              );
                            },
                          );
                        },
                        openBuilder: (context, close) {
                          return CommonInternetPackageSearchWidgets(
                            useServiceResponse: widget.detailFetchData,
                            renewOptions: _renewOption,
                            onChanged: (val) {
                              _packageController.text = val["text"] ?? "";
                              _selectedPackageId = val["id"]?.toString() ?? "";
                              _amountController.text = ((double.tryParse(
                                              val["amount"]?.toString() ??
                                                  "0") ??
                                          0) +
                                      _dueAmount)
                                  .toString();
                            },
                          );
                        },
                      ),
                    ),
                  if (_changePackage || (_isPackageAvailable == false))
                    SizedBox(height: 20.hp),

                  // CustomTextField(title: "Amount", hintText: "Enter the amount"),
                  SizedBox(height: _height * 0.01),
                  // Container(
                  //   padding: const EdgeInsets.only(top: 7),
                  //   height: _height * 0.12,
                  //   width: double.infinity,
                  //   child: GridView.builder(
                  //     itemCount: 6,
                  //     gridDelegate:
                  //         const SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 3, childAspectRatio: 1.4 / 0.6),
                  //     itemBuilder: (context, index) => amountBox(context, index),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          onButtonPressed: () {
            final packageID = idd.first["id"];
            final body = {
              "id": packageID,
              "packageId": packageID,
            };
            NavigationService.push(
              target: TransactionPinScreen(
                onValueCallback: (mpin) {
                  NavigationService.pop();
                  context.read<UtilityPaymentCubit>().makePayment(
                        mPin: mpin,
                        body: body,
                        serviceIdentifier: widget.service.uniqueIdentifier,
                        accountDetails: {
                          "username": widget.detailFetchData.findValue(
                            primaryKey: "hashResponse",
                            secondaryKey: "userName",
                          ),
                          "amount": widget.detailFetchData.findValue(
                              primaryKey: "hashResponse",
                              secondaryKey: "amount"),
                          "account_number":
                              RepositoryProvider.of<CustomerDetailRepository>(
                                      context)
                                  .selectedAccount
                                  .value
                                  ?.accountNumber,
                        },
                        apiEndpoint: "/api/internetpay",
                      );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
