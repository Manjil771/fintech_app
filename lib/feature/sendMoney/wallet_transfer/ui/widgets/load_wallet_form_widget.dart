import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/contact_utils.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/more/transactionLimit/transaction_progress_page.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_list_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_send_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_transfer_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_validation_model.dart';

class LoadWalletFormWidget extends StatefulWidget {
  final String? phoneNumber;
  final WalletModel selectedWallet;
  final String? remarks;
  final String? imageUrl;

  const LoadWalletFormWidget(
      {Key? key,
      required this.selectedWallet,
      this.phoneNumber,
      this.remarks,
      this.imageUrl})
      : super(key: key);

  @override
  State<LoadWalletFormWidget> createState() => _LoadWalletFormWidgetState();
}

class _LoadWalletFormWidgetState extends State<LoadWalletFormWidget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _walletAccountController =
      TextEditingController();
  String _currentAmount = '';
  final TextEditingController _remarksController = TextEditingController();
  checkAccount() {
    if (widget.phoneNumber != null) {
      _walletAccountController.text = widget.phoneNumber.toString();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _toggleBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        height: 500,
        decoration: const BoxDecoration(
          color: CustomTheme.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: TransactionProgressPage(
          persistOpen: true,
          title: "Wallet".tr(),
          profileType: "WalletProfile".tr(),
          isOpen: true,
        ),
      ),
    );
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
      scaffoldKey: _scaffoldKey,
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
                          imageUrl: widget.imageUrl,
                          serviceName: "Load Wallet".tr(),
                          body: Column(children: [
                            KeyValueTile(
                                title: "Wallet".tr(),
                                value: _response.findValue(
                                  primaryKey: "walletName",
                                )),
                            KeyValueTile(
                                title: "To Account".tr(),
                                value: _response.findValue(
                                  primaryKey: "descOneFieldValue",
                                )),
                            KeyValueTile(
                                title: "Amount".tr(),
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
                      NavigationService.pop();
                    },
                    showCancelButton: false,
                  );
                }
              } else if (state is CommonError) {
                showPopUpDialog(
                  context: context,
                  message: state.message,
                  title: "Error".tr(),
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                  showCancelButton: false,
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
                  final WalletValidationModel? _myValidationResult = state.data;

                  _isAccountValidated = true;
                  _validationResult = state.data;
                  showPopUpDialog(
                    context: context,
                    message:
                        "Wallet ID Validated successfully. Do you want to continue transfer?"
                            .tr(),
                    title: "Confirm".tr(),
                    buttonCallback: () {
                      NavigationService.pop();
                      NavigationService.push(target: TransactionPinScreen(
                        onValueCallback: (p0) {
                          NavigationService.pop();
                          context.read<WalletSendCubit>().sendToWallet(
                                mPin: p0,
                                remarks: _remarksController.text,
                                walletId: widget.selectedWallet.id.toString(),
                                amount: _amountController.text,
                                customerName: _walletAccountController.text,
                                walletAccountNumber:
                                    _walletAccountController.text,
                                validationIdentifier:
                                    _myValidationResult?.validationIdentifier ??
                                        "",
                              );
                        },
                      ));
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
          verificationAmount: _currentAmount,
          onRecentTransactionPressed: (p0) {
            // NavigationService.pop();

            // widget.selectedWallet =
            // p0.requestDetail.destinationBankName.toString();
            _walletAccountController.text = p0.serviceTo.toString();

            _amountController.text = p0.totalAmount.toString();
            _remarksController.text = p0.customerRemarks.toString();
            setState(() {});
          },
          associatedId: widget.selectedWallet.id.toString(),
          showRecentTransaction: true,
          showDetail: true,
          serviceName: "WALLET".tr(),
          showAccountSelection: true,
          topbarName: "Load Wallet".tr(),
          title: "Load ${widget.selectedWallet.name}",
          detail:
              "Load money to your preferred ${widget.selectedWallet.name} account",
          buttonName:
              _isAccountValidated ? "Load Wallet".tr() : "Check Transfer".tr(),
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
                        showSuffixImage: true,
                        suffixImage: "assets/icons/Contact from phone.svg",
                        onSurffixImagePress: () async {
                          final String? pickedContact =
                              await ContactUtils.pickContact;
                          if (pickedContact != null) {
                            _walletAccountController.text =
                                removeSpecificPatterns(pickedContact);
                            setState(() {});
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            final String newText = newValue.text
                                .replaceAll('+977', '')
                                .replaceAll('-', '');
                            return TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                          }),
                        ],
                        onSuffixPressed: () async {
                          final String phoneNumber =
                              await SecureStorageService.appPhoneNumber;
                          _walletAccountController.text = phoneNumber;
                          setState(() {});
                        },
                      )
                    : CustomTextField(
                        title: "Wallet Id".tr(),
                        controller: _walletAccountController,
                        validator: (val) => FormValidator.validateFieldNotEmpty(
                            val, "Wallet Id"),
                      ),
                CustomTextField(
                  showTransLimit: true,
                  transLimitFunc: _toggleBottomSheet,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  title: "Amount".tr(),
                  hintText: "Enter the amount".tr(),
                  onChanged: (value) {
                    setState(() {
                      _currentAmount = value;
                    });
                  },
                  controller: _amountController,
                  validator: (value) => FormValidator.validateAmount(
                      val: value.toString(),
                      minAmount: widget.selectedWallet.minAmount,
                      maxAmount: widget.selectedWallet.maxAmount),
                  // validator: (val) {
                  //   if (val == null) {
                  //     return "Amount field cannot be empty";
                  //   }
                  //   if ((int.tryParse(val) ?? 0) < 100) {
                  //     return "Minimum amount to transfer is Rs. 100";
                  //   } else if ((int.tryParse(val) ?? 0) > 25000) {
                  //     return "Maximum amount to transfer is Rs. 25000";
                  //   }
                  //   return null;
                  // },
                  textInputType: TextInputType.number,
                ),
                CustomTextField(
                  title: "Remarks".tr(),
                  hintText: "Remarks".tr(),
                  controller: _remarksController..text = widget.remarks ?? "",
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Remarks"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String removeSpecificPatterns(String input) {
    if (input.startsWith('+977')) {
      input = input.substring(4);
    }
    input = input.replaceAll('-', '');
    return input;
  }
}
