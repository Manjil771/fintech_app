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
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/cubits/internal_transfer_cubit.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/models/internal_branch.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/screen/select_co_op_branch.dart';

class InternalCooperativeWidget extends StatefulWidget {
  const InternalCooperativeWidget({Key? key}) : super(key: key);

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

          if (state is CommonStateSuccess) {
            showPopUpDialog(
              context: context,
              message: state.data,
              showCancelButton: false,
              title: "Success",
              buttonCallback: () {
                NavigationService.popUntilFirstPage();
              },
            );
          } else if (state is CommonError) {
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
                  title: "Destation Account",
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
                Text(
                  "Charge : Rs. 0",
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
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Remarks"),
                )
              ],
            ),
          ),
          topbarName: "Send Money",
          onButtonPressed: () {
            if (_formKey.currentState!.validate() && internalBranch != null) {
              print(internalBranch);
              NavigationService.push(
                target: TransactionPinScreen(
                  onValueCallback: (pin) {
                    NavigationService.pop();
                    context.read<InternalTransferCubit>().fundTranfer(
                          amount: _amountController.text,
                          mpin: pin,
                          remarks: _remarksController.text,
                          receivingAccount: (internalBranch?.branchCode ?? "") +
                              "-" +
                              _accountController.text,
                          receivingBranchId: internalBranch?.branchCode ?? "",
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
          },
          buttonName: "Proceed",
          title: "Internal Cooperative",
          detail: "Send Money to account maintained at same Coop.",
        ),
      ),
    );
  }
}
