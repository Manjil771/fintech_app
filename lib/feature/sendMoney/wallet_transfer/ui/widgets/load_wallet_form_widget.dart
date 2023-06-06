import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_list_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_send_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_transfer_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_validation_model.dart';

class LoadWalletFormWidget extends StatefulWidget {
  final WalletModel selectedWallet;
  const LoadWalletFormWidget({Key? key, required this.selectedWallet})
      : super(key: key);

  @override
  State<LoadWalletFormWidget> createState() => _LoadWalletFormWidgetState();
}

class _LoadWalletFormWidgetState extends State<LoadWalletFormWidget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _walletAccountController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isAccountValidated = false;
  WalletValidationModel? _validationResult;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PageWrapper(
      body: MultiBlocListener(
        listeners: [
          BlocListener<WalletSendCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoading && !_isLoading) {
                _isLoading = true;
                showLoadingDialogBox(context);
              } else if (state is! CommonLoading && _isLoading) {
                _isLoading = false;
                NavigationService.pop();
              }
              if (state is CommonStateSuccess<WalletTransferModel>) {
                showPopUpDialog(
                  context: context,
                  message: state.data.message,
                  title: state.data.status,
                  buttonCallback: () {
                    // NavigationService.pop();
                    NavigationService.popUntilFirstPage();
                  },
                  showCancelButton: false,
                );
              } else if (state is CommonError) {
                SnackBarUtils.showErrorBar(
                  context: context,
                  message: state.message,
                );
              }
            },
          ),
          BlocListener<WalletListCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonLoading && !_isLoading) {
                _isLoading = true;
                showLoadingDialogBox(context);
              } else if (state is! CommonLoading && _isLoading) {
                _isLoading = false;
                NavigationService.pop();
              }

              if (state is CommonStateSuccess<WalletValidationModel>) {
                if (state.data.validationIdentifier != null &&
                    state.data.status.toLowerCase() == "success") {
                  _isAccountValidated = true;
                  _validationResult = state.data;
                  showPopUpDialog(
                    context: context,
                    message:
                        "Wallet ID Validated successfully. Do you want to continue transfer? ",
                    title: "Confirm",
                    buttonCallback: () {
                      NavigationService.pop();
                      context.read<WalletSendCubit>().sendToWallet(
                            walletId: widget.selectedWallet.id.toString(),
                            amount: _amountController.text,
                            customerName: _walletAccountController.text,
                            walletAccountNumber: _walletAccountController.text,
                            validationIdentifier:
                                _validationResult?.validationIdentifier ?? "",
                          );
                    },
                  );
                  _isAccountValidated = false;

                  _validationResult = null;
                } else {
                  SnackBarUtils.showErrorBar(
                    context: context,
                    message: state.data.message,
                  );
                }
              } else if (state is CommonError) {
                _isAccountValidated = false;
                SnackBarUtils.showErrorBar(
                  context: context,
                  message: state.message,
                );
              }
            },
            child: Container(),
          )
        ],
        child: CommonContainer(
          topbarName: "Load Wallet",
          buttonName: _isAccountValidated ? "Load Wallet" : "Check Transfer",
          onButtonPressed: () {
            if (!_isAccountValidated && _validationResult == null) {
              if (_formKey.currentState!.validate()) {
                context.read<WalletListCubit>().validateWallet(
                      walletId: widget.selectedWallet.id.toString(),
                      accountNumber: _walletAccountController.text,
                      amount: _amountController.text,
                    );
              }
            }
          },
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Load ${widget.selectedWallet.name}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Load money to your preferred ${widget.selectedWallet.name} account.",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  widget.selectedWallet.descOneFieldName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child:
                //     ),
                //     Container(
                //       padding: const EdgeInsets.all(6),
                //       margin: const EdgeInsets.only(left: 8, top: 28),
                //       height: size.height * 0.06,
                //       width: size.width * 0.12,
                //       child:
                //           SvgPicture.asset("assets/icons/Contact from phone.svg"),
                //     )
                //   ],
                // ),
                CustomTextField(
                  title: "Wallet Id",
                  hintText: "9856654121",
                  controller: _walletAccountController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Wallet Id"),
                  showSearchIcon: true,
                  suffixIcon: Icons.mobile_friendly,
                  onSuffixPressed: () {
                    final _userPhone =
                        RepositoryProvider.of<CustomerDetailRepository>(context)
                                .customerDetailModel
                                .value
                                ?.mobileNumber ??
                            "";
                    _walletAccountController.text = _userPhone;
                  },
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextField(
                  title: "Amount",
                  hintText: "Enter the amount",
                  controller: _amountController,
                  validator: (val) {
                    if (val == null) {
                      return "Amount field cannot be empty";
                    }
                    if ((int.tryParse(val) ?? 0) < 100) {
                      return "Minimum amount to transfer is Rs. 100";
                    } else if ((int.tryParse(val) ?? 0) > 25000) {
                      return "Maximum amount to transfer is Rs. 25000";
                    }
                    return null;
                  },
                  textInputType: TextInputType.number,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 7),
                  height: size.height * 0.12,
                  width: double.infinity,
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 1.4 / 0.6),
                    itemBuilder: (context, index) => amountBox(context, index),
                  ),
                ),
                CustomTextField(
                  title: "Remarks",
                  hintText: "Remarks",
                  controller: _remarksController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Remarks"),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Recent Transaction",
                //       style: Theme.of(context).textTheme.headlineSmall,
                //     ),
                //     TextButton(
                //         onPressed: () {},
                //         child: Text(
                //           "View All",
                //           style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //               fontFamily: "popinmedium",
                //               fontSize: 16),
                //         ))
                //   ],
                // ),
                // SizedBox(height: size.height * 0.02)
              ],
            ),
          ),
        ),
      ),
    );
  }

  amountBox(context, index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Center(child: Text(amount[index].toString())),
    );
  }

  final List amount = [100, 200, 500, 1000, 2000, 5000];
}
