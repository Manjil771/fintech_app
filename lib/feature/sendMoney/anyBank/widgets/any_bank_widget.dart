import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/bank_list_page.dart';
import 'package:ismart/feature/sendMoney/cubits/bank_charge_cubit.dart';
import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class AnyBankWidget extends StatefulWidget {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;

  const AnyBankWidget(
      {Key? key, this.accountNumber, this.accountName, this.bankCode})
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
  @override
  void initState() {
    checkAccount();
    super.initState();
  }

  checkAccount() {
    if (widget.accountName != null) {
      _accountNameController.text = widget.accountName.toString();
      _accountNumberController.text = widget.accountNumber.toString();
      _selectedBankController.text = widget.bankCode.toString();
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
                showPopUpDialog(
                  context: context,
                  message: state.data,
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
                  padding: EdgeInsets.all(8),
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
                widget.bankCode == null
                    ? CustomTextField(
                        hintText: "Select Bank",
                        title: "Select Bank",
                        readOnly: true,
                        controller: _selectedBankController,
                        onTap: () {
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
                        },
                        validator: (value) {
                          if (selectedBank != null) {
                            return null;
                          } else {
                            return "Please select destination bank.";
                          }
                        },
                      )
                    : CustomTextField(
                        title: "Select Bank",
                        controller: _selectedBankController,
                        readOnly: true,
                      ),
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
                      bankId: selectedBank?.bankId ?? "",
                      destinationAccountName: _accountNameController.text,
                      destinationAccountNumber: _accountNumberController.text,
                      destinationBankId: widget.bankCode == null
                          ? selectedBank?.bankId ?? ""
                          : widget.bankCode.toString(),
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
                            destinationBankInstrumentCode:
                                widget.bankCode == null
                                    ? selectedBank?.bankId ?? ""
                                    : widget.bankCode.toString(),
                            destinationBankAccountName:
                                _accountNameController.text,
                            destinationBankAccountNumber:
                                _accountNumberController.text,
                            destinationBankName: widget.bankCode == null
                                ? selectedBank?.bankName ?? ""
                                : "ismart",
                            sendingAccount:
                                RepositoryProvider.of<CustomerDetailRepository>(
                                        context)
                                    .accountsList
                                    .value
                                    .first
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
