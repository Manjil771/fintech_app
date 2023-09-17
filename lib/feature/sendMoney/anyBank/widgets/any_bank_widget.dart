import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/bank_list_page.dart';
import 'package:ismart/feature/sendMoney/cubits/bank_charge_cubit.dart';
import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';
import 'package:string_similarity/string_similarity.dart';

class AnyBankWidget extends StatefulWidget {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? bankName;

  const AnyBankWidget(
      {Key? key,
      this.accountNumber,
      this.accountName,
      this.bankCode,
      this.bankName})
      : super(key: key);

  @override
  State<AnyBankWidget> createState() => _AnyBankWidgetState();
}

class _AnyBankWidgetState extends State<AnyBankWidget> {
  bool mobilePhoneTransfer = false;
  final TextEditingController _selectedBankController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  Bank? selectedBank;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? bestMatchBankId;

  @override
  void initState() {
    if (widget.bankCode != null) {
      context.read<SendToBankCubit>().fetchBanksList();
    }
    checkAccount();
    super.initState();
  }

  checkAccount() {
    if (widget.accountName != null) {
      _accountNameController.text = widget.accountName.toString();
      _accountNumberController.text = widget.accountNumber.toString();
      _selectedBankController.text = widget.bankName.toString();
    }
  }

  bool _isLoading = false;
  String? charges;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: MultiBlocListener(
        listeners: [
          BlocListener<SendToBankCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoading && _isLoading == false) {
                _isLoading = true;
                showLoadingDialogBox(context);
              } else if (state is! CommonLoading && _isLoading) {
                _isLoading = false;
                NavigationService.pop();
              }
              if (state is CommonStateSuccess) {
                NavigationService.pushReplacement(
                    target: CommonTransactionSuccessPage(
                        body: Column(children: [
                          KeyValueTile(
                              title: "From Account",
                              value: RepositoryProvider.of<
                                      CustomerDetailRepository>(context)
                                  .selectedAccount
                                  .value!
                                  .accountNumber),
                          KeyValueTile(
                              title: "To Account",
                              value: _accountNumberController.text),
                          KeyValueTile(
                              title: "Account Holder Name",
                              value: _accountNameController.text),
                          KeyValueTile(
                            title: "To Bank",
                            value: widget.bankCode == null
                                ? selectedBank?.bankName ?? ""
                                : widget.bankName ?? "ismart",
                          ),
                          KeyValueTile(
                            title: "Charge",
                            value: charges ?? "0",
                          ),
                          KeyValueTile(
                            title: "Amount",
                            value: _amountController.text,
                          ),
                        ]),
                        message: "Transaction Completed",
                        transactionID: state.data));
              } else if (state is CommonDataFetchSuccess<Bank>) {
                List<Bank> _banks = state.data;
                List<String> _bankNames = [];
                state.data.forEach((element) {
                  _bankNames.add(element.bankName);
                });
                BestMatch _match = widget.bankName.bestMatch(_bankNames);
                Bank _bestMatchBank = _banks.firstWhere(
                  (element) {
                    return element.bankName.contains(
                      _bankNames[_match.bestMatchIndex],
                    );
                  },
                  orElse: () {
                    return Bank(
                      bankId: "-1",
                      refBankId: "refBankId",
                      bankName: widget.bankName ?? "",
                      enabled: "",
                      lastModifiedOn: "",
                      swiftCode: "",
                      iconUrl: "",
                    );
                  },
                );
                if (_bestMatchBank.bankId != "-1") {
                  bestMatchBankId = _bestMatchBank.bankId;
                }
                print(bestMatchBankId);
                setState(() {});
              }
              if (state is CommonError) {
                showPopUpDialog(
                  context: context,
                  message: state.message,
                  title: "Message",
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                  showCancelButton: false,
                );
              }
            },
            child: Container(),
          ),
          BlocListener<BankChargeCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoading && _isLoading == false) {
                _isLoading = true;
                showLoadingDialogBox(context);
              } else if (state is! CommonLoading && _isLoading) {
                _isLoading = false;
                NavigationService.pop();
              }
              if (state is CommonStateSuccess) {
                SnackBarUtils.showSuccessBar(
                  context: context,
                  message: "Account validated successfully.",
                );
                charges = state.data;
                setState(() {});
              } else if (state is CommonError) {
                showPopUpDialog(
                  context: context,
                  message: state.message,
                  title: "Error",
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                  showCancelButton: false,
                );
              }
            },
            child: Container(),
          )
        ],
        child: CommonContainer(
          showDetail: true,
          showAccountSelection: true,
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.black12),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              mobilePhoneTransfer = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: mobilePhoneTransfer
                                  ? Colors.black12
                                  : Colors.white,
                            ),
                            height: _height * 0.04,
                            child: Center(
                              child: Text(
                                "Account Number",
                                style: _textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: _width * 0.05),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              mobilePhoneTransfer = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: mobilePhoneTransfer
                                  ? Colors.white
                                  : Colors.black12,
                            ),
                            height: _height * 0.04,
                            child: Center(
                              child: Text(
                                "Mobile Number",
                                style: _textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: _height * 0.02),
                // widget.bankCode == null
                //     ?
                CustomTextField(
                  hintText: "Select Bank",
                  title: "Select Bank",
                  readOnly: widget.bankCode != null,
                  controller: _selectedBankController,
                  onTap: bestMatchBankId != null
                      ? () {
                          NavigationService.push(
                            target: BankListPage(
                              onBankSelected: (val) {
                                NavigationService.pop();

                                _selectedBankController.text = val.bankName;
                                selectedBank = val;
                                setState(() {});
                              },
                            ),
                          );
                        }
                      : null,
                  validator: (value) => FormValidator.validateFieldNotEmpty(
                      value, "Destination bank."),
                ),
                // : CustomTextField(
                //     title: "Select Bank",
                //     controller: _selectedBankController,
                //     readOnly: true,
                //   ),
                CustomTextField(
                  title: "Account Number",
                  hintText: "Destination Account Number",
                  controller: _accountNumberController,
                  validator: (val) => FormValidator.validateFieldNotEmpty(
                      val, "Account Number"),
                ),
                mobilePhoneTransfer
                    ? CustomTextField(
                        title: "Mobile Number",
                        hintText: "Account Holder Phone Number",
                        //controller: _accountNameController,
                        validator: (val) => FormValidator.validateFieldNotEmpty(
                            val, "Phone Number"),
                      )
                    : CustomTextField(
                        hintText: "Account Holder Name",
                        controller: _accountNameController,
                        validator: (val) => FormValidator.validateFieldNotEmpty(
                            val, "Account Name"),
                      ),
                CustomTextField(
                  title: "Amount",
                  hintText: "NPR ",
                  controller: _amountController,
                  onChanged: (val) {
                    if (val != _amountController.text) {
                      charges = null;
                      setState(() {});
                    }
                  },
                  validator: (val) {
                    if ((int.tryParse(val ?? "") ?? 0) < 100) {
                      return "Minimum bank tranfer amount is Rs. 100";
                    } else if ((int.tryParse(val ?? "") ?? 0) > 200000) {
                      return "Maximum bank transfer amount is Rs. 2,00,000";
                    } else {
                      return null;
                    }
                  },
                ),
                if (charges != null)
                  Text(
                    "Charge : Rs. " + charges!,
                    style: _textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  title: "Remarks",
                  hintText: "Remarks",
                  controller: _remarksController,
                  validator: (value) =>
                      FormValidator.validateFieldNotEmpty(value, "Remarks"),
                ),
              ],
            ),
          ),
          topbarName: "Send Money",
          buttonName: charges != null ? "Confirm" : "Check Transfer",
          onButtonPressed: () {
            // NavigationService.push(target: const LimitScreen());
            if (_formKey.currentState!.validate()) {
              if (charges == null) {
                context.read<BankChargeCubit>().getBankCharges(
                      amount: _amountController.text,
                      bankId: bestMatchBankId ??
                          (widget.bankCode ?? selectedBank?.bankId ?? ""),
                      destinationAccountName: _accountNameController.text,
                      destinationAccountNumber: _accountNumberController.text,
                      destinationBankId: bestMatchBankId ??
                          (widget.bankCode ?? selectedBank?.bankId ?? ""),
                    );
              } else {
                NavigationService.push(
                  target: TransactionPinScreen(
                    onValueCallback: (pin) {
                      NavigationService.pop();
                      context.read<SendToBankCubit>().sendMoneyToBank(
                            charge: charges.toString(),
                            amount: _amountController.text,
                            mpin: pin,
                            remarks: _remarksController.text,
                            destinationBankInstrumentCode: bestMatchBankId ??
                                (widget.bankCode == null
                                    ? selectedBank?.bankId ?? ""
                                    : widget.bankCode.toString()),
                            destinationBankAccountName:
                                _accountNameController.text,
                            destinationBankAccountNumber:
                                _accountNumberController.text,
                            destinationBankName: widget.bankCode == null
                                ? selectedBank?.bankName ?? ""
                                : widget.bankName ?? "ismart",
                            sendingAccount:
                                RepositoryProvider.of<CustomerDetailRepository>(
                                        context)
                                    .selectedAccount
                                    .value!
                                    .accountNumber,
                          );
                    },
                  ),
                );
              }
            }
          },
          title: "Any Bank",
          detail: "Transfer funds to accounts held at various banks.",
        ),
      ),
    );
  }
}
