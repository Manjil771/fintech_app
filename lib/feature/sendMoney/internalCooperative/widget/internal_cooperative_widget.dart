import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/cubits/internal_transfer_cubit.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/models/internal_branch.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/screen/select_co_op_branch.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class InternalCooperativeWidget extends StatefulWidget {
  final String? accountNumber;
  final String? accountName;
  final String? bankCode;
  final String? branchCode;
  final String? remarks;

  const InternalCooperativeWidget(
      {Key? key,
      this.accountNumber,
      this.accountName,
      this.bankCode,
      this.branchCode,
      this.remarks})
      : super(key: key);

  @override
  State<InternalCooperativeWidget> createState() =>
      _InternalCooperativeWidgetState();
}

class _InternalCooperativeWidgetState extends State<InternalCooperativeWidget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _accountName = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InternalBranch? internalBranch;

  getDetails() {
    if (widget.accountName != null) {
      _accountController.text = widget.accountNumber.toString();
      _accountName.text = widget.accountName.toString();
      _branchController.text = widget.bankCode.toString();
      internalBranch = InternalBranch(
        id: 1,
        name: widget.bankCode.toString(),
        address: "",
        branchCode: widget.branchCode.toString(),
        bank: "",
        city: "",
        checker: false,
        maker: false,
        state: "",
        bankId: 1,
        bankCode: "",
        cbsBranchCode: "",
        email: "",
        branchId: "",
        latitude: "",
        longitude: "",
        nchl: "",
        fax: "",
        telephoneNumber: "",
        branchManager: "",
        createdDate: DateTime.now(),
      );
    }
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: BlocListener<InternalTransferCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            UtilityResponseData _response = state.data;
            if (_response.code == "M0000" ||
                _response.status.toLowerCase() == "success") {
              NavigationService.pushReplacement(
                target: CommonTransactionSuccessPage(
                  body: Column(
                    children: [
                      KeyValueTile(
                        title: "From Account",
                        value: RepositoryProvider.of<CustomerDetailRepository>(
                                context)
                            .selectedAccount
                            .value!
                            .accountNumber,
                      ),
                      KeyValueTile(
                          title: "To Account", value: _accountController.text),
                      KeyValueTile(
                          title: "Account Holder Name",
                          value: _accountName.text),
                      KeyValueTile(
                          title: "Amount", value: _amountController.text)
                    ],
                  ),
                  message: _response.message,
                  transactionID: _response.findValue(
                    primaryKey: "transactionIdentifier",
                  ),
                ),
              );
            } else {
              showPopUpDialog(
                context: context,
                message: _response.message,
                showCancelButton: false,
                title: _response.status,
                buttonCallback: () {
                  NavigationService.pushReplacement(
                    target: const DashboardPage(),
                  );
                },
              );
            }
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
        },
        child: CommonContainer(
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  title: "Branch",
                  hintText: "Select Branch",
                  readOnly: true,
                  controller: _branchController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Branch"),
                  onTap: () {
                    NavigationService.push(
                      target: CoOperativeBranchPage(
                        onBankSelected: (val) {
                          NavigationService.pop();
                          internalBranch = val;
                          _branchController.text = val.name;
                        },
                      ),
                    );
                  },
                ),
                CustomTextField(
                  title: "Destination Account",
                  hintText: "Account Number",
                  controller: _accountController,
                  validator: (val) => FormValidator.validateFieldNotEmpty(
                      val, "Account Number"),
                ),
                CustomTextField(
                  hintText: "Account Holder Name",
                  controller: _accountName,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Account Name"),
                ),
                CustomTextField(
                  title: "Amount",
                  textInputType: TextInputType.number,
                  hintText: "NPR",
                  controller: _amountController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Amount"),
                ),
                // Text(
                //   "Charge : Rs. 0",
                //   style: _textTheme.displayMedium!.copyWith(
                //     fontWeight: FontWeight.bold,
                //     fontSize: 12,
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  title: "Remarks",
                  hintText: "Remarks",
                  controller: _remarksController..text = widget.remarks ?? "",
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Remarks"),
                )
              ],
            ),
          ),
          topbarName: "Send Money",
          showDetail: true,
          onButtonPressed: () {
            if (_formKey.currentState!.validate() && internalBranch != null) {
              print(internalBranch);
              NavigationService.push(
                target: TransactionPinScreen(
                  onValueCallback: (pin) {
                    String _receivingAccount = "";
                    if (widget.accountNumber == null) {
                      _receivingAccount = (internalBranch?.branchCode ?? "") +
                          _accountController.text;
                    } else {
                      _receivingAccount = (widget.branchCode ?? "") +
                          (widget.accountNumber ?? "");
                    }
                    NavigationService.pop();
                    context.read<InternalTransferCubit>().fundTranfer(
                          amount: _amountController.text,
                          mpin: pin,
                          remarks: _remarksController.text,
                          receivingAccount: _receivingAccount,
                          receivingBranchId: internalBranch?.branchCode ?? "",
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
          },
          showAccountSelection: true,
          buttonName: "Proceed",
          title: "Internal Cooperative",
          detail: "Send Money to account maintained at same Coop.",
        ),
      ),
    );
  }
}
