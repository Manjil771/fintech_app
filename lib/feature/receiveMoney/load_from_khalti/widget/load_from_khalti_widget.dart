import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:ismart/feature/receiveMoney/cubit/khalti_txn_confirm_cubit.dart';
import 'package:ismart/feature/receiveMoney/cubit/receive_money_cubit.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart';

class LoadFromKhaltiWidget extends StatefulWidget {
  const LoadFromKhaltiWidget({Key? key}) : super(key: key);

  @override
  State<LoadFromKhaltiWidget> createState() => _LoadFromKhaltiWidgetState();
}

class _LoadFromKhaltiWidgetState extends State<LoadFromKhaltiWidget> {
  Khalti? khalti;

  //  String _token = "";

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  // final TextEditingController _bankNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Bank? selectedBank;
  String? pidx;

  @override
  void initState() {
    // TODO: implement initState

    // _token = RepositoryProvider.of<UserRepository>(context).token;

    super.initState();
  }

  bool _isLoading = false;
  String stateis = "";

  String generatedTransactionId = "2";
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: BlocListener<ReceiveMoneyCubit, CommonState>(
        listener: (context, state) async {
          stateis = state.toString();
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }
          if (state is CommonStateSuccess) {
            final List<String> _data = state.data.toString().split("-");
            generatedTransactionId = _data[3].toString();
            // print("my data is " + _data.toString() + _data[3]);
            if (_data.isNotEmpty) {
              stateis = state.toString();

              pidx = _data[0];
              final payConfig = KhaltiPayConfig(
                publicKey: _data[1],
                pidx: _data[0],
                // returnUrl: Uri.parse('https://ismart.devanasoft.com'),
                environment: Environment.prod,
                openInKhalti: true,
              );

              khalti = await Khalti.init(
                enableDebugging: false,
                payConfig: payConfig,
                onPaymentResult: (paymentResult, khalti) {
                  context.read<KhaltiTxnConfirmCubit>().completeKhaltiTxn(
                        amount: _amountController.text,
                        status: paymentResult.payload?.status ?? "",
                        transaction_id:
                            paymentResult.payload?.transactionId ?? "",
                        pidx: paymentResult.payload?.pidx ?? "",
                      );
                },
                onMessage: (
                  khalti, {
                  description,
                  statusCode,
                  event,
                  needsPaymentConfirmation,
                }) async {
                  // if (event == KhaltiEvent) {
                  //   SnackBarUtils.showErrorBar(
                  //       context: context,
                  //       message: "Please check transaction for details. ");
                  // }
                },
                onReturn: () {
                  khalti!.close(context);
                  NavigationService.pushReplacement(
                    target: CommonTransactionSuccessPage(
                      body: Column(
                        children: [
                          KeyValueTile(
                              title: "Amount", value: _amountController.text),
                          KeyValueTile(
                              title: "Remarks", value: _remarksController.text),
                        ],
                      ),
                      message: "Transaction Complete",
                      transactionID: generatedTransactionId,
                      serviceName: "Load Money",
                    ),
                  );
                },
              );
              if (khalti != null) {
                khalti!.open(context);
              } else {
                SnackBarUtils.showErrorBar(
                  context: context,
                  message: "Error when connecting to server. Please retry.",
                );
              }
            }
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
          showDetail: true,
          showAccountSelection: true,
          accountTitle: "To Account",
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputType: TextInputType.number,
                    title: "Amount",
                    hintText: "NPR ",
                    controller: _amountController,
                    validator: (value) =>
                        FormValidator.validateFieldNotEmpty(value, "Amount")
                    // validator: (val) {
                    // if ((int.tryParse(val ?? "") ?? 0) < 10) {
                    //   return "Minimum amount is Rs. 10";
                    // } else if ((int.tryParse(val ?? "") ?? 0) > 200000) {
                    //   return "Maximum amount is Rs. 2,00,000";
                    // } else {
                    //   return null;
                    // }
                    // },
                    ),
                CustomTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
          buttonName: "Proceed",
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ReceiveMoneyCubit>().loadFromKhalti(
                    amount: _amountController.text,
                    remarks: _remarksController.text,
                    accountNumber:
                        RepositoryProvider.of<CustomerDetailRepository>(context)
                                .selectedAccount
                                .value
                                ?.accountNumber ??
                            "",
                  );
            }
          },
          title: "Load Fund",
          detail: "Load fund instantly to your account.",
        ),
      ),
    );
  }
}
