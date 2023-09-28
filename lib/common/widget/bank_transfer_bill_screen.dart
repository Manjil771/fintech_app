import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/bank_transfer_receipt.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class BankTransferBillPage extends StatelessWidget {
  final String? charge;
  final String? amount;
  final String serviceName;
  final String? remarks;
  final String? bankCode;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;
  final Widget body;
  final String message;

  BankTransferBillPage(
      {super.key,
      required this.body,
      this.charge,
      this.amount,
      this.remarks,
      this.bankCode,
      this.accountName,
      this.accountNumber,
      this.bankName,
      required this.serviceName,
      required this.message});
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return BlocProvider(
      create: (context) => SendToBankCubit(
        sendToBankRepository:
            RepositoryProvider.of<SendToBankRepository>(context),
      ),
      child: BankTransferBillWidget(
        accountName: accountName,
        message: message,
        accountNumber: accountNumber,
        amount: amount,
        bankCode: bankCode,
        bankName: bankName,
        charge: charge,
        remarks: remarks,
        body: body,
        serviceName: serviceName,
      ),
    );
  }
}

class BankTransferBillWidget extends StatefulWidget {
  final Widget body;
  final String? charge;
  final String? amount;
  final String serviceName;

  final String message;
  final String? remarks;
  final String? bankCode;
  final String? accountName;
  final String? accountNumber;
  final String? bankName;

  BankTransferBillWidget({
    super.key,
    required this.body,
    this.charge,
    this.amount,
    this.remarks,
    this.bankCode,
    this.accountName,
    this.accountNumber,
    this.bankName,
    required this.serviceName,
    required this.message,
  });

  @override
  State<BankTransferBillWidget> createState() => _BankTransferBillWidgetState();
}

class _BankTransferBillWidgetState extends State<BankTransferBillWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return PageWrapper(
      body: BlocListener<SendToBankCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          }
          if (state is! CommonLoading && _isLoading) {
            NavigationService.pop();
            _isLoading = false;
          }

          if (state is CommonStateSuccess) {
            NavigationService.pushReplacement(
                target: BankTransferReciptPage(
              transactionID: state.data.toString(),
              body: widget.body,
              message: "Transaction Success for the Service",
            ));
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
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        NavigationService.pop();
                      },
                      icon: Icon(Icons.arrow_back)),
                  Center(
                    child: Image.asset(
                      Assets.moneyTransferIcon,
                      height: _height * 0.08,
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  Center(
                    child: Text(
                      widget.serviceName,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  Text(
                      "Details about the payable amount for the service of ${widget.serviceName} is shown below.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: _height * 0.02),
                  const Divider(thickness: 1),
                  SizedBox(height: _height * 0.02),
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF3F3F3),
                      // border: Border.all(color: Colors.black),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Paymet Details",
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: _height * 0.02),
                        widget.body,
                      ],
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  CustomRoundedButtom(
                      title: "Confirm",
                      onPressed: () {
                        NavigationService.push(target: TransactionPinScreen(
                          onValueCallback: (p0) {
                            NavigationService.pop();

                            context.read<SendToBankCubit>().sendMoneyToBank(
                                  charge: widget.charge ?? "",
                                  amount: widget.amount ?? "",

                                  mpin: p0,
                                  remarks: widget.remarks ?? "",
                                  destinationBankInstrumentCode:
                                      widget.bankCode ?? "",
                                  // bestMatchBankId ??
                                  //     (widget.bankCode == null
                                  //         ? selectedBank?.bankId ?? ""
                                  //         : widget.bankCode.toString()),
                                  destinationBankAccountName:
                                      widget.accountName ?? "",

                                  destinationBankAccountNumber:
                                      widget.accountNumber ?? "",
                                  destinationBankName: widget.bankName ?? "",
                                  // destinationBankName: widget.bankCode == null
                                  //     ? selectedBank?.bankName ?? ""
                                  //     : widget.bankName ?? "ismart",
                                  sendingAccount: RepositoryProvider.of<
                                          CustomerDetailRepository>(context)
                                      .selectedAccount
                                      .value!
                                      .accountNumber,
                                  //             );
                                );
                          },
                        ));
                      }),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(18),
                  //       border:
                  //           Border.all(color: Theme.of(context).primaryColor)),
                  //   child: CustomRoundedButtom(
                  //       textColor: Theme.of(context).primaryColor,
                  //       title: "Download Receipt",
                  //       color: Colors.transparent,
                  //       onPressed: () {}),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
