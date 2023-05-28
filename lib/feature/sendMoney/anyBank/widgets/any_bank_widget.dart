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
import 'package:ismart/feature/sendMoney/anyBank/screen/bank_list_page.dart';
import 'package:ismart/feature/sendMoney/cubits/bank_charge_cubit.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class AnyBankWidget extends StatefulWidget {
  const AnyBankWidget({Key? key}) : super(key: key);

  @override
  State<AnyBankWidget> createState() => _AnyBankWidgetState();
}

class _AnyBankWidgetState extends State<AnyBankWidget> {
  final TextEditingController _selectedBankController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  Bank? selectedBank;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                setState(() {});
              }
            },
            child: Container(),
          )
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
                ),
                CustomTextField(
                  title: "Destination Account",
                  hintText: "Destination Account Number",
                  controller: _accountNumberController,
                  validator: (val) => FormValidator.validateFieldNotEmpty(
                      val, "Account Number"),
                ),
                CustomTextField(
                  hintText: "Account Holder Name",
                  controller: _accountNameController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Account Name"),
                ),
                CustomTextField(
                  title: "Amount",
                  hintText: "NPR ",
                  controller: _amountController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Amount"),
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
                ),
              ],
            ),
          ),
          topbarName: "Send Money",
          buttonName: charges != null ? "Send" : "Check Transfer",
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              if (charges == null) {
                context.read<BankChargeCubit>().getBankCharges(
                      amount: _amountController.text,
                      bankId: selectedBank?.bankId ?? "",
                    );
              } else {
                // Call bank transfer API
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
