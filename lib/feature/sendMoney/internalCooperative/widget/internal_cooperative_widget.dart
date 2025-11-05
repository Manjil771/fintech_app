import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/more/transactionLimit/transaction_progress_page.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/cubits/coop_list_cubit.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/models/internal_branch.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/resources/internal_transfer_repository.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/screen/select_co_op_branch.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/widget/internal_coop_bill_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class InternalCooperativeWidget extends StatefulWidget {
  final String? accountNumber;
  final bool? isFavAccount;
  final String? branchName;
  final String branchId;
  final String? accountName;
  final String? branchCodeQr;
  final String? remarks;

  const InternalCooperativeWidget(
      {Key? key,
      this.accountNumber,
      this.accountName,
      this.branchCodeQr,
      this.remarks,
      this.isFavAccount = false,
      this.branchName,
      required this.branchId})
      : super(key: key);

  @override
  State<InternalCooperativeWidget> createState() =>
      _InternalCooperativeWidgetState();
}

class _InternalCooperativeWidgetState extends State<InternalCooperativeWidget> {
  String? branchId;
  String? branchCode;

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  String _currentAmount = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InternalBranch? branchFromQr;
  bool _isLoading = false;
  InternalBranch? selectedIDFromQr;
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
        child: const TransactionProgressPage(
          persistOpen: true,
          title: "Internal Fund Transfer ",
          profileType: 'CustomerProfile',
          isOpen: true,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _accountNumberController.text = widget.accountNumber ?? "";
    _accountNameController.text = widget.accountName ?? "";
    _branchController.text = widget.branchName ?? "";
    _remarksController.text = widget.remarks ?? "";
    // branchId = widget.branchId;
    // branchCode = widget.branchCodeQr;
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      scaffoldKey: _scaffoldKey,
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            final UtilityResponseData _response = state.data;
            if (_response.code == "M0000" ||
                _response.status.toLowerCase() == "success") {
              final finalBranchCode = widget.branchId.isEmpty
                  ? branchCode ?? selectedIDFromQr?.branchCode ?? ""
                  : widget.branchCodeQr;
              final finalAccountNumber = widget.branchId.isEmpty
                  ? _accountNumberController.text
                  : widget.accountNumber;

              NavigationService.pushReplacement(
                  target: InternalCoopBillDetailPage(
                message: _response.message,
                body: Column(
                  children: [
                    KeyValueTile(
                        title: LocaleKeys.fromaccount.tr(),
                        value: RepositoryProvider.of<CustomerDetailRepository>(
                                context)
                            .selectedAccount
                            .value!
                            .accountNumber),
                    KeyValueTile(
                        title: "To Account",
                        value:
                            "${branchId ?? widget.branchCodeQr.toString()}${_accountNumberController.text}"),
                    KeyValueTile(
                        title: "Destination A/C Name",
                        value: _accountNameController.text),
                    // KeyValueTile(
                    //     title: "Branch Code",
                    //     value: branchId ?? widget.branchCodeQr.toString()),
                    KeyValueTile(
                        title: "Remarks".tr(), value: _remarksController.text),
                    KeyValueTile(
                        title: "Total Amount", value: _amountController.text),
                  ],
                ),
                accountName: _accountNameController.text,
                accountNumber: "$finalBranchCode$finalAccountNumber",
                // accountNumber: widget.isFavAccount == true
                //     ? (widget.branchCodeQr.toString() +
                //         widget.accountNumber.toString())
                //     : (selectedIDFromQr?.bankCode ?? branchCode.toString()) +
                //         _accountNumberController.text,
                amount: _amountController.text,
                branchCode: finalBranchCode.toString(),
                remarks: _remarksController.text,
              ));
            } else {
              showPopUpDialog(
                context: context,
                message: _response.message,
                showCancelButton: false,
                title: _response.status,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          }
          if (state is CommonError) {
            showPopUpDialog(
              context: context,
              message: state.message,
              title: "Error".tr(),
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }
        },
        child: CommonContainer(
          verificationAmount: _currentAmount,
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isFavAccount == true
                    ? CustomTextField(
                        readOnly: true,
                        title: "Branch ${widget.branchCodeQr}",
                        controller: _branchController,
                      )
                    : widget.branchCodeQr == null
                        ? CustomTextField(
                            title: "Branch".tr(),
                            hintText: "Select Branch".tr(),
                            readOnly: true,
                            controller: _branchController,
                            validator: (val) =>
                                FormValidator.validateFieldNotEmpty(
                                    val, "Branch".tr()),
                            onTap: () {
                              NavigationService.push(
                                target: CoOperativeBranchPage(
                                  onBankSelected: (val) {
                                    NavigationService.pop();
                                    branchCode = val.branchCode;
                                    branchId = val.id.toString();
                                    _branchController.text = val.name;
                                  },
                                ),
                              );
                            },
                          )
                        : BlocProvider(
                            lazy: false,
                            create: (context) => CoopListCubit(
                                internalTransferRepository: RepositoryProvider
                                    .of<InternalTransferRepository>(context))
                              ..fetchBanksList(),
                            child: BlocConsumer<CoopListCubit, CommonState>(
                              builder: (context, state) {
                                print("state of state is $state");
                                if (state
                                    is CommonDataFetchSuccess<InternalBranch>) {
                                  selectedIDFromQr = state.data.firstWhere(
                                      (element) =>
                                          element.branchCode ==
                                          widget.branchCodeQr);
                                  return CustomTextField(
                                    readOnly: true,
                                    title: "Branch ",
                                    customHintTextStyle: true,
                                    hintText: selectedIDFromQr?.name ?? "",
                                  );
                                } else {
                                  return Container();
                                }
                              },
                              listener: (context, state) {},
                            )),
                CustomTextField(
                  title: "Destination Account".tr(),
                  hintText: "Account Number".tr(),
                  controller: _accountNumberController,
                  validator: (val) => FormValidator.validateFieldNotEmpty(
                      val, "Account Number"),
                ),
                CustomTextField(
                  hintText: "Account Holder Name".tr(),
                  controller: _accountNameController,
                  validator: (val) => FormValidator.validateFieldNotEmpty(
                      val, "Account Name".tr()),
                ),
                CustomTextField(
                  showTransLimit: true,
                  transLimitFunc: _toggleBottomSheet,
                  title: "Amount".tr(),
                  textInputType: TextInputType.number,
                  hintText: "NPR".tr(),
                  onChanged: (value) {
                    setState(() {
                      _currentAmount = value;
                    });
                  },
                  controller: _amountController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Amount".tr()),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  title: "Remarks".tr(),
                  hintText: "Remarks".tr(),
                  controller: _remarksController..text = widget.remarks ?? "",
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Remarks".tr()),
                )
              ],
            ),
          ),
          topbarName: "Fund Transfer".tr(),
          showDetail: true,
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<UtilityPaymentCubit>().fetchDetails(
                  serviceIdentifier: "",
                  accountDetails: {
                    "destinationAccountNumber": _accountNumberController.text,
                    "destinationAccountName": _accountNameController.text,
                    "destinationBranchId": widget.isFavAccount == true
                        ? widget.branchId
                        : branchId ?? selectedIDFromQr?.id.toString() ?? "",
                  },
                  apiEndpoint: "/api/account/validation");
            }
          },
          showAccountSelection: true,
          buttonName: "Proceed".tr(),
          title: "Internal Cooperative".tr(),
          detail: "Send Money to account maintained at same Coop.".tr(),
        ),
      ),
    );
  }
}
