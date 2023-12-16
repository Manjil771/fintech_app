import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/bank_transfer_bill_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/bank_list_page.dart';
import 'package:ismart/feature/sendMoney/cubits/bank_charge_cubit.dart';
import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_repository.dart';

class AnyBankWidget extends StatefulWidget {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? bankName;
  final String? remarks;

  const AnyBankWidget(
      {Key? key,
      this.accountNumber,
      this.accountName,
      this.bankCode,
      this.bankName,
      this.remarks})
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
  String? bestMatchBankName;

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
                charges = state.data;

                if (charges != null) {
                  NavigationService.pushReplacement(
                      target: BankTransferBillPage(
                    imageUrl: selectedBank?.iconUrl ?? "",
                    body: Column(children: [
                      KeyValueTile(
                          title: "From Account",
                          value:
                              RepositoryProvider.of<CustomerDetailRepository>(
                                      context)
                                  .selectedAccount
                                  .value!
                                  .accountNumber),
                      KeyValueTile(
                        title: "Destination Bank",
                        value: widget.bankCode == null
                            ? selectedBank?.bankName ?? ""
                            : widget.bankName ?? "ismart",
                      ),
                      KeyValueTile(
                          title: "Destination Account Number",
                          value: _accountNumberController.text),
                      KeyValueTile(
                          title: "Destination Account Name",
                          value: _accountNameController.text),
                      KeyValueTile(
                        title: "Charge",
                        value: charges ?? "0",
                      ),
                      KeyValueTile(
                        title: "Amount",
                        value: _amountController.text,
                      ),
                      KeyValueTile(
                        title: "Remarks",
                        value: _remarksController.text,
                      ),
                    ]),
                    serviceName: "Bank Transfer",
                    message:
                        "Details for payment of service Bank Transfer is shown below.",
                    charge: charges.toString(),
                    amount: _amountController.text,
                    remarks: _remarksController.text,
                    bankCode: bestMatchBankId ??
                        (widget.bankCode == null
                            ? selectedBank?.bankId ?? ""
                            : widget.bankCode.toString()),
                    accountName: _accountNameController.text,
                    accountNumber: _accountNumberController.text,
                    bankName: widget.bankCode == null
                        ? selectedBank?.bankName ?? ""
                        : widget.bankName ?? "ismart",
                  ));
                } else {
                  showPopUpDialog(
                    context: context,
                    message: state.data,
                    title: "Error",
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
          serviceName: "CONNECT_IPS",
          showRecentTransaction: true,
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
                widget.bankName == null
                    ? CustomTextField(
                        hintText: "Select Bank",
                        title: "Select Bank",
                        readOnly: widget.bankCode != null,
                        controller: _selectedBankController,
                        onTap:
                            // bestMatchBankId != null
                            // ?
                            () {
                          NavigationService.push(
                            target: BankListPage(
                              onBankSelected: (val) {
                                bestMatchBankId = null;
                                NavigationService.pop();

                                _selectedBankController.text = val.bankName;
                                selectedBank = val;
                                setState(() {});
                              },
                            ),
                          );
                        },
                        // : null,
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Destination bank."),
                      )
                    : BlocProvider(
                        lazy: false,
                        create: (context) => SendToBankCubit(
                            sendToBankRepository:
                                RepositoryProvider.of<SendToBankRepository>(
                                    context))
                          ..fetchBanksList(),
                        child: BlocConsumer<SendToBankCubit, CommonState>(
                          builder: (context, state) {
                            print("state of state is $state");
                            if (state is CommonDataFetchSuccess<Bank>) {
                              List<Bank> _banks = state.data;
                              List<String> _bankNames = [];
                              double highestMatch = 0;
                              int selectedIndex = -1;
                              print(
                                  "ISMARTCHECK : Checking for Bank : ${widget.bankName}");
                              state.data.forEach((element) {
                                final matchValue = jaro(
                                    widget.bankName
                                            ?.toLowerCase()
                                            .replaceAll("ltd", "limited") ??
                                        "",
                                    element.bankName
                                        .toLowerCase()
                                        .replaceAll("ltd", "limited"));
                                print(
                                    "ISMARTCHECK : Bank Name : ${element.bankName} MatchRation : $matchValue");
                                if (matchValue > highestMatch) {
                                  highestMatch = matchValue;
                                  selectedIndex = state.data.indexOf(element);
                                }
                              });
                              print("\n\n\nBEST MATCH\n\n");
                              print(highestMatch);
                              print(state.data[selectedIndex].bankName);
                              bestMatchBankId =
                                  state.data[selectedIndex].bankId;
                              bestMatchBankName =
                                  state.data[selectedIndex].bankName;
                              return CustomTextField(
                                readOnly: true,
                                title: "Branch ",
                                customHintTextStyle: true,
                                hintText: bestMatchBankName ?? "",
                              );
                            } else {
                              return Container();
                            }
                          },
                          listener: (context, state) {},
                        )),
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  title: "Amount",
                  hintText: "NPR",
                  textInputType: TextInputType.numberWithOptions(decimal: true),
                  controller: _amountController,
                  onChanged: (val) {
                    if (val != _amountController.text) {
                      charges = null;
                      setState(() {});
                    }
                  },
                  // validator: (value) =>
                  //     FormValidator.validateFieldNotEmpty(value, "Amount"),
                  validator: (val) {
                    if ((double.tryParse(val ?? "") ?? 0) < 100) {
                      return "Minimum bank tranfer amount is Rs. 100";
                    } else if ((double.tryParse(val ?? "") ?? 0) > 200000) {
                      return "Maximum bank transfer amount is Rs. 2,00,000";
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextField(
                  title: "Remarks",
                  hintText: "Remarks",
                  controller: _remarksController..text = widget.remarks ?? "",
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
              context.read<BankChargeCubit>().getBankCharges(
                    amount: _amountController.text,
                    bankId: bestMatchBankId ??
                        (widget.bankCode ?? selectedBank?.bankId ?? ""),
                    destinationAccountName: _accountNameController.text,
                    destinationAccountNumber: _accountNumberController.text,
                    destinationBankId: bestMatchBankId ??
                        (widget.bankCode ?? selectedBank?.bankId ?? ""),
                  );

              // else {
              //   NavigationService.push(
              //     target: TransactionPinScreen(
              //       onValueCallback: (pin) {
              //         NavigationService.pop();
              //         context.read<SendToBankCubit>().sendMoneyToBank(
              //               charge: charges.toString(),
              //               amount: _amountController.text,
              //               mpin: pin,
              //               remarks: _remarksController.text,
              //               destinationBankInstrumentCode: bestMatchBankId ??
              //                   (widget.bankCode == null
              //                       ? selectedBank?.bankId ?? ""
              //                       : widget.bankCode.toString()),
              //               destinationBankAccountName:
              //                   _accountNameController.text,
              //               destinationBankAccountNumber:
              //                   _accountNumberController.text,
              //               destinationBankName: widget.bankCode == null
              //                   ? selectedBank?.bankName ?? ""
              //                   : widget.bankName ?? "ismart",
              //               sendingAccount:
              //                   RepositoryProvider.of<CustomerDetailRepository>(
              //                           context)
              //                       .selectedAccount
              //                       .value!
              //                       .accountNumber,
              //             );
              //       },
              //     ),
              //   );
              // }
            }
          },
          title: "Any Bank",
          detail: "Transfer funds to accounts held at various banks.",
        ),
      ),
    );
  }
}

double jaro(String s1, String s2) {
  if (s1.isEmpty || s2.isEmpty) return 0.0;

  int matchDistance = (s1.length / 2).floor() - 1;
  List<bool> s1Matches = List.filled(s1.length, false);
  List<bool> s2Matches = List.filled(s2.length, false);

  int matches = 0;
  int transpositions = 0;

  for (int i = 0; i < s1.length; i++) {
    int start = max(0, i - matchDistance);
    int end = min(s2.length - 1, i + matchDistance);

    for (int j = start; j <= end; j++) {
      if (s2Matches[j]) continue;
      if (s1[i] != s2[j]) continue;
      s1Matches[i] = true;
      s2Matches[j] = true;
      matches++;
      break;
    }
  }

  if (matches == 0) return 0.0;

  int k = 0;
  for (int i = 0; i < s1.length; i++) {
    if (!s1Matches[i]) continue;
    while (!s2Matches[k]) k++;
    if (s1[i] != s2[k]) transpositions++;
    k++;
  }

  double jaroScore = (matches / s1.length +
          matches / s2.length +
          (matches - transpositions / 2.0) / matches) /
      3.0;
  return jaroScore;
}

double jaroWinkler(String s1, String s2) {
  const double prefixWeight = 0.1;

  double jaroDistance = jaro(s1, s2);
  int prefixLength = 0;

  for (int i = 0; i < min(s1.length, s2.length); i++) {
    if (s1[i] == s2[i])
      prefixLength++;
    else
      break;
  }

  double score =
      jaroDistance + prefixWeight * prefixLength * (1 - jaroDistance);
  return score * 100; // Convert score to a range between 0 and 100
}

//this is how you should call the method:
void main() {
  print(jaroWinkler("dwayne", "duane")); // Should be close to 0.84
}

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/form_validator.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/util/snackbar_utils.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/common_text_field.dart';
// import 'package:ismart/common/widget/common_transaction_success_screen.dart';
// import 'package:ismart/common/widget/key_value_tile.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/common/widget/show_loading_dialog.dart';
// import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// import 'package:ismart/common/widget/transactipon_pin_screen.dart';
// import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// import 'package:ismart/feature/sendMoney/anyBank/screen/bank_list_page.dart';
// import 'package:ismart/feature/sendMoney/cubits/bank_charge_cubit.dart';
// import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
// import 'package:ismart/feature/sendMoney/models/bank.dart';

// class AnyBankWidget extends StatefulWidget {
//   final String? accountNumber;
//   final String? accountName;
//   final String? bankCode;
//   final String? bankName;
//   final String? remarks;

//   const AnyBankWidget(
//       {Key? key,
//       this.accountNumber,
//       this.accountName,
//       this.bankCode,
//       this.bankName,
//       this.remarks})
//       : super(key: key);

//   @override
//   State<AnyBankWidget> createState() => _AnyBankWidgetState();
// }

// class _AnyBankWidgetState extends State<AnyBankWidget> {
//   bool mobilePhoneTransfer = false;
//   final TextEditingController _selectedBankController = TextEditingController();
//   final TextEditingController _accountNumberController =
//       TextEditingController();
//   final TextEditingController _accountNameController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _remarksController = TextEditingController();
//   Bank? selectedBank;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String? bestMatchBankId;

//   @override
//   void initState() {
//     if (widget.bankCode != null) {
//       context.read<SendToBankCubit>().fetchBanksList();
//     }
//     checkAccount();
//     super.initState();
//   }

//   checkAccount() {
//     if (widget.accountName != null) {
//       _accountNameController.text = widget.accountName.toString();
//       _accountNumberController.text = widget.accountNumber.toString();
//       _selectedBankController.text = widget.bankName.toString();
//     }
//   }

//   bool _isLoading = false;
//   String? charges;
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     return PageWrapper(
//       body: MultiBlocListener(
//         listeners: [
//           BlocListener<SendToBankCubit, CommonState>(
//             listener: (context, state) {
//               if (state is CommonLoading && _isLoading == false) {
//                 _isLoading = true;
//                 showLoadingDialogBox(context);
//               } else if (state is! CommonLoading && _isLoading) {
//                 _isLoading = false;
//                 NavigationService.pop();
//               }
//               if (state is CommonStateSuccess) {
//                 NavigationService.pushReplacement(
//                     target: CommonTransactionSuccessPage(
//                         body: Column(children: [
//                           KeyValueTile(
//                               title: "From Account",
//                               value: RepositoryProvider.of<
//                                       CustomerDetailRepository>(context)
//                                   .selectedAccount
//                                   .value!
//                                   .accountNumber),
//                           KeyValueTile(
//                               title: "To Account",
//                               value: _accountNumberController.text),
//                           KeyValueTile(
//                               title: "Account Holder Name",
//                               value: _accountNameController.text),
//                           KeyValueTile(
//                             title: "To Bank",
//                             value: widget.bankCode == null
//                                 ? selectedBank?.bankName ?? ""
//                                 : widget.bankName ?? "ismart",
//                           ),
//                           KeyValueTile(
//                             title: "Charge",
//                             value: charges ?? "0",
//                           ),
//                           KeyValueTile(
//                             title: "Amount",
//                             value: _amountController.text,
//                           ),
//                         ]),
//                         message: "Transaction Completed",
//                         transactionID: state.data));
//               } else if (state is CommonDataFetchSuccess<Bank>) {
//                 List<Bank> _banks = state.data;
//                 List<String> _bankNames = [];
//                 double highestMatch = 0;
//                 int selectedIndex = -1;
//                 print("ISMARTCHECK : Checking for Bank : ${widget.bankName}");
//                 state.data.forEach((element) {
//                   final matchValue = jaro(
//                       widget.bankName
//                               ?.toLowerCase()
//                               .replaceAll("ltd", "limited") ??
//                           "",
//                       element.bankName
//                           .toLowerCase()
//                           .replaceAll("ltd", "limited"));
//                   print(
//                       "ISMARTCHECK : Bank Name : ${element.bankName} MatchRation : $matchValue");
//                   if (matchValue > highestMatch) {
//                     highestMatch = matchValue;
//                     selectedIndex = state.data.indexOf(element);
//                   }
//                 });
//                 print("\n\n\nBEST MATCH\n\n");
//                 print(highestMatch);
//                 print(state.data[selectedIndex].bankName);
//                 bestMatchBankId = state.data[selectedIndex].bankId;
//                 setState(() {});
//               }
//               if (state is CommonError) {
//                 showPopUpDialog(
//                   context: context,
//                   message: state.message,
//                   title: "Message",
//                   buttonCallback: () {
//                     NavigationService.pop();
//                   },
//                   showCancelButton: false,
//                 );
//               }
//             },
//             child: Container(),
//           ),
//           BlocListener<BankChargeCubit, CommonState>(
//             listener: (context, state) {
//               if (state is CommonLoading && _isLoading == false) {
//                 _isLoading = true;
//                 showLoadingDialogBox(context);
//               } else if (state is! CommonLoading && _isLoading) {
//                 _isLoading = false;
//                 NavigationService.pop();
//               }
//               if (state is CommonStateSuccess) {
//                 SnackBarUtils.showSuccessBar(
//                   context: context,
//                   message: "Account validated successfully.",
//                 );
//                 charges = state.data;
//                 setState(() {});
//               } else if (state is CommonError) {
//                 showPopUpDialog(
//                   context: context,
//                   message: state.message,
//                   title: "Error",
//                   buttonCallback: () {
//                     NavigationService.pop();
//                   },
//                   showCancelButton: false,
//                 );
//               }
//             },
//             child: Container(),
//           )
//         ],
//         child: CommonContainer(
//           serviceName: "CONNECT_IPS",
//           showRecentTransaction: true,
//           showDetail: true,
//           showAccountSelection: true,
//           body: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(18),
//                       color: Colors.black12),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               mobilePhoneTransfer = false;
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: mobilePhoneTransfer
//                                   ? Colors.black12
//                                   : Colors.white,
//                             ),
//                             height: _height * 0.04,
//                             child: Center(
//                               child: Text(
//                                 "Account Number",
//                                 style: _textTheme.titleSmall,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: _width * 0.05),
//                       Expanded(
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               mobilePhoneTransfer = true;
//                             });
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: mobilePhoneTransfer
//                                   ? Colors.white
//                                   : Colors.black12,
//                             ),
//                             height: _height * 0.04,
//                             child: Center(
//                               child: Text(
//                                 "Mobile Number",
//                                 style: _textTheme.titleSmall,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: _height * 0.02),
//                 // widget.bankCode == null
//                 //     ?
//                 CustomTextField(
//                   hintText: "Select Bank",
//                   title: "Select Bank",
//                   readOnly: widget.bankCode != null,
//                   controller: _selectedBankController,
//                   onTap:
//                       // bestMatchBankId != null
//                       // ?
//                       () {
//                     NavigationService.push(
//                       target: BankListPage(
//                         onBankSelected: (val) {
//                           bestMatchBankId = null;
//                           NavigationService.pop();

//                           _selectedBankController.text = val.bankName;
//                           selectedBank = val;
//                           setState(() {});
//                         },
//                       ),
//                     );
//                   },
//                   // : null,
//                   validator: (value) => FormValidator.validateFieldNotEmpty(
//                       value, "Destination bank."),
//                 ),
//                 // : CustomTextField(
//                 //     title: "Select Bank",
//                 //     controller: _selectedBankController,
//                 //     readOnly: true,
//                 //   ),
//                 CustomTextField(
//                   title: "Account Number",
//                   hintText: "Destination Account Number",
//                   controller: _accountNumberController,
//                   validator: (val) => FormValidator.validateFieldNotEmpty(
//                       val, "Account Number"),
//                 ),
//                 mobilePhoneTransfer
//                     ? CustomTextField(
//                         title: "Mobile Number",
//                         hintText: "Account Holder Phone Number",
//                         //controller: _accountNameController,
//                         validator: (val) => FormValidator.validateFieldNotEmpty(
//                             val, "Phone Number"),
//                       )
//                     : CustomTextField(
//                         hintText: "Account Holder Name",
//                         controller: _accountNameController,
//                         validator: (val) => FormValidator.validateFieldNotEmpty(
//                             val, "Account Name"),
//                       ),
//                 CustomTextField(
//                   title: "Amount",
//                   hintText: "NPR ",
//                   textInputType: TextInputType.number,
//                   controller: _amountController,
//                   onChanged: (val) {
//                     if (val != _amountController.text) {
//                       charges = null;
//                       setState(() {});
//                     }
//                   },
//                   validator: (val) {
//                     if ((int.tryParse(val ?? "") ?? 0) < 100) {
//                       return "Minimum bank tranfer amount is Rs. 100";
//                     } else if ((int.tryParse(val ?? "") ?? 0) > 200000) {
//                       return "Maximum bank transfer amount is Rs. 2,00,000";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 if (charges != null)
//                   Text(
//                     "Charge : Rs. " + charges!,
//                     style: _textTheme.displayMedium!.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 CustomTextField(
//                   title: "Remarks",
//                   hintText: "Remarks",
//                   controller: _remarksController..text = widget.remarks ?? "",
//                   validator: (value) =>
//                       FormValidator.validateFieldNotEmpty(value, "Remarks"),
//                 ),
//               ],
//             ),
//           ),
//           topbarName: "Send Money",
//           buttonName: charges != null ? "Confirm" : "Check Transfer",
//           onButtonPressed: () {
//             // NavigationService.push(target: const LimitScreen());
//             if (_formKey.currentState!.validate()) {
//               if (charges == null) {
//                 context.read<BankChargeCubit>().getBankCharges(
//                       amount: _amountController.text,
//                       bankId: bestMatchBankId ??
//                           (widget.bankCode ?? selectedBank?.bankId ?? ""),
//                       destinationAccountName: _accountNameController.text,
//                       destinationAccountNumber: _accountNumberController.text,
//                       destinationBankId: bestMatchBankId ??
//                           (widget.bankCode ?? selectedBank?.bankId ?? ""),
//                     );
//               } else {
//                 NavigationService.push(
//                   target: TransactionPinScreen(
//                     onValueCallback: (pin) {
//                       NavigationService.pop();
//                       context.read<SendToBankCubit>().sendMoneyToBank(
//                             charge: charges.toString(),
//                             amount: _amountController.text,
//                             mpin: pin,
//                             remarks: _remarksController.text,
//                             destinationBankInstrumentCode: bestMatchBankId ??
//                                 (widget.bankCode == null
//                                     ? selectedBank?.bankId ?? ""
//                                     : widget.bankCode.toString()),
//                             destinationBankAccountName:
//                                 _accountNameController.text,
//                             destinationBankAccountNumber:
//                                 _accountNumberController.text,
//                             destinationBankName: widget.bankCode == null
//                                 ? selectedBank?.bankName ?? ""
//                                 : widget.bankName ?? "ismart",
//                             sendingAccount:
//                                 RepositoryProvider.of<CustomerDetailRepository>(
//                                         context)
//                                     .selectedAccount
//                                     .value!
//                                     .accountNumber,
//                           );
//                     },
//                   ),
//                 );
//               }
//             }
//           },
//           title: "Any Bank",
//           detail: "Transfer funds to accounts held at various banks.",
//         ),
//       ),
//     );
//   }
// }

// double jaro(String s1, String s2) {
//   if (s1.isEmpty || s2.isEmpty) return 0.0;

//   int matchDistance = (s1.length / 2).floor() - 1;
//   List<bool> s1Matches = List.filled(s1.length, false);
//   List<bool> s2Matches = List.filled(s2.length, false);

//   int matches = 0;
//   int transpositions = 0;

//   for (int i = 0; i < s1.length; i++) {
//     int start = max(0, i - matchDistance);
//     int end = min(s2.length - 1, i + matchDistance);

//     for (int j = start; j <= end; j++) {
//       if (s2Matches[j]) continue;
//       if (s1[i] != s2[j]) continue;
//       s1Matches[i] = true;
//       s2Matches[j] = true;
//       matches++;
//       break;
//     }
//   }

//   if (matches == 0) return 0.0;

//   int k = 0;
//   for (int i = 0; i < s1.length; i++) {
//     if (!s1Matches[i]) continue;
//     while (!s2Matches[k]) k++;
//     if (s1[i] != s2[k]) transpositions++;
//     k++;
//   }

//   double jaroScore = (matches / s1.length +
//           matches / s2.length +
//           (matches - transpositions / 2.0) / matches) /
//       3.0;
//   return jaroScore;
// }

// double jaroWinkler(String s1, String s2) {
//   const double prefixWeight = 0.1;

//   double jaroDistance = jaro(s1, s2);
//   int prefixLength = 0;

//   for (int i = 0; i < min(s1.length, s2.length); i++) {
//     if (s1[i] == s2[i])
//       prefixLength++;
//     else
//       break;
//   }

//   double score =
//       jaroDistance + prefixWeight * prefixLength * (1 - jaroDistance);
//   return score * 100; // Convert score to a range between 0 and 100
// }

// //this is how you should call the method:
// void main() {
//   print(jaroWinkler("dwayne", "duane")); // Should be close to 0.84
// }
