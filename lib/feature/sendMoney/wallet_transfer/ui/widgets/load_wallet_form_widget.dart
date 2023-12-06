import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_list_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_send_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_transfer_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_validation_model.dart';

class LoadWalletFormWidget extends StatefulWidget {
  final String? phoneNumber;
  final WalletModel selectedWallet;
  final String? remarks;

  const LoadWalletFormWidget(
      {Key? key, required this.selectedWallet, this.phoneNumber, this.remarks})
      : super(key: key);

  @override
  State<LoadWalletFormWidget> createState() => _LoadWalletFormWidgetState();
}

class _LoadWalletFormWidgetState extends State<LoadWalletFormWidget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _walletAccountController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  checkAccount() {
    if (widget.phoneNumber != null) {
      _walletAccountController.text = widget.phoneNumber.toString();
    }
  }

  @override
  void initState() {
    checkAccount();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isAccountValidated = false;
  WalletValidationModel? _validationResult;

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: MultiBlocListener(
        listeners: [
          BlocListener<WalletSendCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoading && !_isLoading) {
                _isLoading = true;
                showLoadingDialogBox(context);
              } else if (state is! CommonLoading && _isLoading) {
                _isLoading = false;
                NavigationService.pop();
              }
              if (state is CommonStateSuccess<WalletTransferModel>) {
                final WalletTransferModel _response = state.data;
                if (state.data.code == "M0000") {
                  NavigationService.pushReplacement(
                      target: CommonTransactionSuccessPage(
                          body: Column(children: [
                            KeyValueTile(
                                title: "Wallet",
                                value: _response.findValue(
                                  primaryKey: "walletName",
                                )),
                            KeyValueTile(
                                title: "To Account",
                                value: _response.findValue(
                                  primaryKey: "descOneFieldValue",
                                )),
                            KeyValueTile(
                                title: "Amount",
                                value: _response.findValue(
                                  primaryKey: "amount",
                                )),
                          ]),
                          message: _response.message,
                          transactionID: _response.findValue(
                            primaryKey: "transactionIdentifier",
                          )));
                } else {
                  showPopUpDialog(
                    context: context,
                    message: state.data.message,
                    title: state.data.status,
                    buttonCallback: () {
                      NavigationService.pushReplacement(
                        target: const DashboardPage(),
                      );
                    },
                    showCancelButton: false,
                  );
                }
              } else if (state is CommonError) {
                SnackBarUtils.showErrorBar(
                  context: context,
                  message: state.message,
                );
              }
            },
          ),
          BlocListener<WalletListCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoading && !_isLoading) {
                _isLoading = true;
                showLoadingDialogBox(context);
              } else if (state is! CommonLoading && _isLoading) {
                _isLoading = false;
                NavigationService.pop();
              }

              if (state is CommonStateSuccess<WalletValidationModel>) {
                if (state.data.status.toLowerCase() == "success" ||
                    state.data.message.toLowerCase() ==
                        "validation not available") {
                  _isAccountValidated = true;
                  _validationResult = state.data;
                  showPopUpDialog(
                    context: context,
                    message:
                        "Wallet ID Validated successfully. Do you want to continue transfer? ",
                    title: "Confirm",
                    buttonCallback: () {
                      NavigationService.pop();
                      context.read<WalletSendCubit>().sendToWallet(
                            remarks: _remarksController.text,
                            walletId: widget.selectedWallet.id.toString(),
                            amount: _amountController.text,
                            customerName: _walletAccountController.text,
                            walletAccountNumber: _walletAccountController.text,
                            validationIdentifier:
                                _validationResult?.validationIdentifier ?? "",
                          );
                    },
                  );
                  _isAccountValidated = false;

                  _validationResult = null;
                } else {
                  SnackBarUtils.showErrorBar(
                    context: context,
                    message: state.data.message,
                  );
                }
              } else if (state is CommonError) {
                _isAccountValidated = false;
                SnackBarUtils.showErrorBar(
                  context: context,
                  message: state.message,
                );
              }
            },
            child: Container(),
          )
        ],
        child: CommonContainer(
          showDetail: true,
          showAccountSelection: true,
          topbarName: "Load Wallet",
          title: "Load ${widget.selectedWallet.name}",
          detail:
              "Load money to your preferred ${widget.selectedWallet.name} account",
          buttonName: _isAccountValidated ? "Load Wallet" : "Check Transfer",
          onButtonPressed: () {
            if (!_isAccountValidated && _validationResult == null) {
              if (_formKey.currentState!.validate()) {
                context.read<WalletListCubit>().validateWallet(
                      walletId: widget.selectedWallet.id.toString(),
                      accountNumber: _walletAccountController.text,
                      amount: _amountController.text,
                    );
              }
            }
          },
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.phoneNumber == null
                    ? CustomTextField(
                        title: "Wallet Id",
                        hintText: "9856654121",
                        controller: _walletAccountController,
                        validator: (val) => FormValidator.validateFieldNotEmpty(
                            val, "Wallet Id"),
                        showSearchIcon: true,
                        suffixIcon: Icons.mobile_friendly,
                        onSuffixPressed: () {
                          final _userPhone =
                              RepositoryProvider.of<CustomerDetailRepository>(
                                          context)
                                      .customerDetailModel
                                      .value
                                      ?.mobileNumber ??
                                  "";
                          _walletAccountController.text = _userPhone;
                        },
                      )
                    : CustomTextField(
                        title: "Wallet Id",
                        controller: _walletAccountController,
                        validator: (val) => FormValidator.validateFieldNotEmpty(
                            val, "Wallet Id"),
                      ),
                CustomTextField(
                  title: "Amount",
                  hintText: "Enter the amount",
                  controller: _amountController,
                  validator: (val) {
                    if (val == null) {
                      return "Amount field cannot be empty";
                    }
                    if ((int.tryParse(val) ?? 0) < 100) {
                      return "Minimum amount to transfer is Rs. 100";
                    } else if ((int.tryParse(val) ?? 0) > 25000) {
                      return "Maximum amount to transfer is Rs. 25000";
                    }
                    return null;
                  },
                  textInputType: TextInputType.number,
                ),
                // Container(
                //   padding: const EdgeInsets.only(top: 7),
                //   height: size.height * 0.12,
                //   width: double.infinity,
                //   child: GridView.builder(
                //     itemCount: 6,
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 3, childAspectRatio: 1.4 / 0.6),
                //     itemBuilder: (context, index) => amountBox(context, index),
                //   ),
                // ),
                CustomTextField(
                  title: "Remarks",
                  hintText: "Remarks",
                  controller: _remarksController..text = widget.remarks ?? "",
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Remarks"),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Recent Transaction",
                //       style: Theme.of(context).textTheme.headlineSmall,
                //     ),
                //     TextButton(
                //         onPressed: () {},
                //         child: Text(
                //           "View All",
                //           style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //               fontFamily: "popinmedium",
                //               fontSize: 16),
                //         ))
                //   ],
                // ),
                // SizedBox(height: size.height * 0.02)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
