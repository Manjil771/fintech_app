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
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/cubit/khanepani_cubit.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/model/khanepani_model.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/screen/khane_pani_counter_page.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/widget/select_counter_widget.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/widget/transaction_detail_alert_widget.dart';

class KhanePaniWidget extends StatefulWidget {
  const KhanePaniWidget({Key? key}) : super(key: key);

  @override
  State<KhanePaniWidget> createState() => _KhanePaniWidgetState();
}

class _KhanePaniWidgetState extends State<KhanePaniWidget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _selectedBankController = TextEditingController();
  KhanePaniModel? selectedBank;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: BlocListener<KhanePaniCubit, CommonState>(
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
                title: "Success",
                showCancelButton: false,
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
            showDetail: true,
            showAccountSelection: true,
            accountTitle: "From Account",
            buttonName: "Proceed",
            topbarName: "Payment",
            title: "KUKL Payment",
            detail: "Pay for your water bill from here.",
            body: Column(
              children: [
                CustomTextField(
                  onTap: () {
                    NavigationService.push(target: SelectKhanePaniCounterPage(
                      onBankSelected: (val) {
                        NavigationService.pop();
                        _selectedBankController.text = val.name;
                        selectedBank = val;
                        setState(() {});
                      },
                    ));
                  },
                  readOnly: true,
                  title: "Select Counter ",
                  hintText: "Select From List",
                  controller: _selectedBankController,
                ),
                SizedBox(height: _height * 0.01),
                CustomTextField(
                  title: "Amount",
                  hintText: "Enter the amount",
                  controller: _amountController,
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Amount"),
                ),
                // Container(
                //   padding: const EdgeInsets.only(top: 7),
                //   height: _height * 0.12,
                //   width: double.infinity,
                //   child: GridView.builder(
                //     itemCount: 6,
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 3, childAspectRatio: 1.4 / 0.6),
                //     itemBuilder: (context, index) => amountBox(context, index),
                //   ),
                // ),
              ],
            ),
            onButtonPressed: () {
              // context.read<UtilityPaymentCubit>().fetchDetails(
              //       serviceIdentifier: "worldlink_online_topup",
              //       accountDetails: {
              //         "wlink_username": "onine_renew"
              //       },
              //       apiEndpoint: "api/wlinkpackages",
              //     );
              // NavigationService.push(
              //   target: TransactionPinScreen(
              //     onValueCallback: (mpin) {
              //       NavigationService.pop();
              //       context.read<UtilityPaymentCubit>().getTopUp(
              //             serviceIdentifier: TopUpUtils()
              //                 .getTopUpServiceType(type: _topUpType.value),
              //             phoneNumber: _mobileNumberController.text,
              //             amount: _amountController.text,
              //             mpin: mpin,
              //           );
              //     },
              //   ),
              // );
              // // NavigationService.push(target: CommonTransactionSuccessfulPage());
            },
          )),
    );
  }
}
