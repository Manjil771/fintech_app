import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/receiveMoney/cubits/receive_from_bank_cubit.dart';
import 'package:ismart/feature/receiveMoney/mobileBanking/screen/receive_bank_list_page.dart';
import 'package:ismart/feature/receiveMoney/mobileBanking/widgets/receive_bank_list_widget.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/bank_list_page.dart';
import 'package:ismart/feature/sendMoney/cubits/bank_charge_cubit.dart';
import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class MobileBankingWidget extends StatefulWidget {
  const MobileBankingWidget({Key? key}) : super(key: key);

  @override
  State<MobileBankingWidget> createState() => _MobileBankingWidgetState();
}

class _MobileBankingWidgetState extends State<MobileBankingWidget> {
  final TextEditingController _selectedBankController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  Bank? selectedBank;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  //String? charges;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReceiveFromBankCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoading && _isLoading) {
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
          // BlocListener<BankChargeCubit, CommonState>(
          //   listener: (context, state) {
          //     if (state is CommonLoading && _isLoading == false) {
          //       _isLoading = true;
          //       showLoadingDialogBox(context);
          //     } else if (state is! CommonLoading && _isLoading) {
          //       _isLoading = false;
          //       NavigationService.pop();
          //     }
          //     if (state is CommonStateSuccess) {
          //       charges = state.data;
          //       setState(() {});
          //     }
          //   },
          //   child: Container(),
          // )
        ],
        child: CommonContainer(
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: "Select Bank",
                  title: "Select Bank",
                  readOnly: true,
                  controller: _selectedBankController,
                  onTap: () {
                    NavigationService.push(
                      target: ReceiveBankListPage(
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
                ),
                // CustomTextField(
                //   title: "Amount",
                //   hintText: "NPR ",
                //   controller: _amountController,
                //   onChanged: (val) {
                //     if (val != _amountController.text) {
                //       setState(() {});
                //     }
                //   },
                //   validator: (val) {
                //     if ((int.tryParse(val ?? "") ?? 0) < 100) {
                //       return "Minimum bank tranfer amount is Rs. 100";
                //     } else if ((int.tryParse(val ?? "") ?? 0) > 200000) {
                //       return "Maximum bank transfer amount is Rs. 2,00,000";
                //     } else {
                //       return null;
                //     }
                //   },
                // ),
                // if (charges != null)
                //   Text(
                //     "Charge : Rs. " + charges!,
                //     style: _textTheme.displayMedium!.copyWith(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 12,
                //     ),
                //   ),
                CustomTextField(
                  title: "Amount",
                  hintText: "NPR 0",
                  controller: _amountController,
                  //   validator: (value) =>
                  //       FormValidator.validateFieldNotEmpty(value, "Remarks"),
                  // ),
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
          topbarName: "Receive Money",
          buttonName: "Confirm",
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              // if (charges == null) {
              //   context.read<BankChargeCubit>().getBankCharges(
              //         amount: _amountController.text,
              //         bankId: selectedBank?.bankId ?? "",
              //       );
              // } else {
              context.read<ReceiveFromBankCubit>().receiveMoneyFromBank(
                    // charge: charges.toString(),
                    amount: _amountController.text,
                    // mpin: "70074",
                    // mpin: "24878",
                    remarks: _remarksController.text,

                    destinationBankInstrumentCode: selectedBank?.bankId ?? "",
                    //destinationBankAccountName: _accountNameController.text,
                    destinationBankAccountNumber: "00100101000002886000001",
                    //destinationBankName: selectedBank?.bankName ?? "",
                  );
            }
            //}
          },
          title: "Mobile Banking",
          detail: "Load fund instantly from mobile banking",
        ),
      ),
    );
  }
}
