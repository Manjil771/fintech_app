import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/smartloan/screen/smart_loan_success_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class SmartLoanApplyWidget extends StatefulWidget {
  final double minLoanAmount;
  final double maxLoanAmount;
  const SmartLoanApplyWidget(
      {super.key, required this.minLoanAmount, required this.maxLoanAmount});

  @override
  State<SmartLoanApplyWidget> createState() => _SmartLoanApplyWidgetState();
}

class _SmartLoanApplyWidgetState extends State<SmartLoanApplyWidget> {
  bool checkAggrement = true;

  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      showBackButton: true,
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
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
          if (state is CommonStateSuccess<UtilityResponseData>) {
            final UtilityResponseData res = state.data;
            if (res.code == "M0000") {
              NavigationService.pushReplacement(
                  target: SmartLoanSuccessScreen(
                message: res.message,
              ));
            } else {
              showPopUpDialog(
                context: context,
                message: res.message,
                title: res.status,
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          }
        },
        child: ValueListenableBuilder<CustomerDetailModel?>(
          valueListenable: customerDetail,
          builder: (context, val, _) {
            if (val != null) {
              final AccountDetail primaryAccount = val.accountDetail.firstWhere(
                  (element) => element.primary.toLowerCase() == "true");
              return Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: CustomTheme.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: ListView(
                    children: [
                      Center(
                        child: Image.asset(
                          Assets.instaLoanIcon,
                          height: 30.hp,
                        ),
                      ),
                      SizedBox(height: 30.hp),
                      Text(
                        val.fullName,
                        style: _textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Account No: " + primaryAccount.accountNumber,
                        style:
                            _textTheme.labelLarge!.copyWith(color: Colors.grey),
                      ),
                      Text(
                        val.addressOne,
                        style:
                            _textTheme.labelLarge!.copyWith(color: Colors.grey),
                      ),
                      Text(
                        "Available Balance: " + primaryAccount.availableBalance,
                        style:
                            _textTheme.labelLarge!.copyWith(color: Colors.grey),
                      ),
                      Text(
                        "Actual Balance: " + primaryAccount.actualBalance,
                        style:
                            _textTheme.labelLarge!.copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 20.hp, child: const Divider()),
                      Text(
                        "Your Available Loan Limit : ",
                        style: _textTheme.labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.hp),
                      Text(
                        "NPR. " +
                            widget.minLoanAmount.toString() +
                            " - " +
                            widget.maxLoanAmount.toString(),
                        style: _textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      SizedBox(height: 20.hp),
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: loanAmountController,
                        title: "Enter Loan Amount",
                        hintText: "Loan Amount",
                        textInputType: TextInputType.number,
                        validator: (value) => FormValidator.validateAmount(
                          val: value.toString(),
                          minAmount: widget.minLoanAmount,
                          maxAmount: widget.maxLoanAmount,
                        ),
                      ),
                      CustomTextField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: remarksController,
                        title: "Remarks",
                        hintText: "Remarks",
                        textInputType: TextInputType.number,
                        validator: (value) =>
                            FormValidator.validateFieldNotEmpty(
                                value, "Remarks"),
                      ),
                      SizedBox(height: 30.hp),
                      CustomRoundedButtom(
                        isDisabled: !checkAggrement,
                        title: "Proceed",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            NavigationService.push(
                              target: TransactionPinScreen(
                                onValueCallback: (p0) {
                                  NavigationService.pop();

                                  context.read<UtilityPaymentCubit>()
                                    ..makePayment(
                                        serviceIdentifier: "",
                                        accountDetails: {
                                          "amount": loanAmountController.text,
                                          "account_number":
                                              primaryAccount.accountNumber,
                                          "remarks": remarksController.text,
                                          "mPin": p0,
                                        },
                                        body: {},
                                        apiEndpoint: "/api/smartLoan/apply",
                                        mPin: "");
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
