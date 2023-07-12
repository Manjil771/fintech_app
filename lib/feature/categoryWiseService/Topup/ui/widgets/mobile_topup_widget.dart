// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/form_validator.dart';
// import 'package:ismart/common/util/regex_utils.dart';
// import 'package:ismart/common/util/secure_storage_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/common_text_field.dart';
// import 'package:ismart/common/widget/common_transaction_success_screen.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/common/widget/show_loading_dialog.dart';
// import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// import 'package:ismart/common/widget/transactipon_pin_screen.dart';
// import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/enums/topup_type.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
// import 'package:ismart/feature/utility_payment/utils/topup_utils.dart';

// class MobileTopUpWidget extends StatefulWidget {
//   final Service? service;

//   const MobileTopUpWidget({super.key, this.service});
//   @override
//   State<MobileTopUpWidget> createState() => _MobileTopUpWidgetState();
// }

// class _MobileTopUpWidgetState extends State<MobileTopUpWidget> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _mobileNumberController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final ValueNotifier<TopupType> _topUpType = ValueNotifier(TopupType.None);
//   void updateTopupType(String number) {
//     _topUpType.value = RegexUtils.checkPhoneNumberType(number);

//     print(_topUpType.value);
//   }

//   @override
//   void initState() {
//     _mobileNumberController.addListener(() {
//       updateTopupType(_mobileNumberController.text);
//     });
//     super.initState();
//   }

//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     return PageWrapper(
//       body: BlocListener<UtilityPaymentCubit, CommonState>(
//           listener: (context, state) {
//             if (state is CommonLoading && _isLoading == false) {
//               _isLoading = true;
//               showLoadingDialogBox(context);
//             } else if (state is! CommonLoading && _isLoading) {
//               _isLoading = false;
//               NavigationService.pop();
//             }

//             if (state is CommonStateSuccess<UtilityResponseData>) {
//               NavigationService.push(
//                   target: CommonTransactionSuccessfulPage(
//                       transactionID: state.data.code,
//                       body: Container(),
//                       message: state.data.message,
//                       service: widget.service));
//             } else if (state is CommonError) {
//               showPopUpDialog(
//                 context: context,
//                 message: state.message,
//                 title: "Error",
//                 showCancelButton: false,
//                 buttonCallback: () {
//                   NavigationService.pop();
//                 },
//               );
//             }
//           },
//           child: CommonContainer(
//             showDetail: true,
//             showAccountSelection: true,
//             accountTitle: "From Account",
//             buttonName: "Proceed",
//             topbarName: "Payment",
//             title: "Mobile Top Up",
//             detail: "Topup your mobile number.",
//             body: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomTextField(
//                           title: "Mobile Number",
//                           hintText: "xxxxxxxxxx",
//                           controller: _mobileNumberController,
//                           validator: FormValidator.validatePhoneNumber,
//                           suffixIcon: Icons.phone_android_outlined,
//                           showSearchIcon: true,
//                           onSuffixPressed: () async {
//                             String phoneNumber =
//                                 await SecureStorageService.appPhoneNumber;
//                             _mobileNumberController.text = phoneNumber;
//                           },
//                         ),
//                       ),
//                       // Container(
//                       //   padding: const EdgeInsets.all(6),
//                       //   margin: const EdgeInsets.only(left: 8, top: 28),
//                       //   height: _height * 0.06,
//                       //   width: _width * 0.12,
//                       //   child: SvgPicture.asset(
//                       //     "assets/icons/Contact from phone.svg",
//                       //   ),
//                       // )
//                     ],
//                   ),
//                   SizedBox(height: _height * 0.01),
//                   CustomTextField(
//                     title: "Amount",
//                     hintText: "Enter the amount",
//                     controller: _amountController,
//                     validator: (val) =>
//                         FormValidator.validateFieldNotEmpty(val, "Amount"),
//                   ),
//                   // Container(
//                   //   padding: const EdgeInsets.only(top: 7),
//                   //   height: _height * 0.12,
//                   //   width: double.infinity,
//                   //   child: GridView.builder(
//                   //     itemCount: 6,
//                   //     gridDelegate:
//                   //         const SliverGridDelegateWithFixedCrossAxisCount(
//                   //             crossAxisCount: 3, childAspectRatio: 1.4 / 0.6),
//                   //     itemBuilder: (context, index) => amountBox(context, index),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             onButtonPressed: () {
//               // context.read<UtilityPaymentCubit>().fetchDetails(
//               //       serviceIdentifier: "worldlink_online_topup",
//               //       accountDetails: {
//               //         "wlink_username": "onine_renew"
//               //       },
//               //       apiEndpoint: "api/wlinkpackages",
//               //     );
//               _formKey.currentState!.save();
//               if (_formKey.currentState!.validate()) {
//                 NavigationService.push(
//                   target: TransactionPinScreen(
//                     onValueCallback: (mpin) {
//                       NavigationService.pop();
//                       context.read<UtilityPaymentCubit>().getTopUp(
//                             serviceIdentifier: TopUpUtils()
//                                 .getTopUpServiceType(type: _topUpType.value),
//                             phoneNumber: _mobileNumberController.text,
//                             amount: _amountController.text,
//                             mpin: mpin,
//                           );
//                     },
//                   ),
//                 );
//               }
//               // NavigationService.push(target: CommonTransactionSuccessfulPage());
//             },
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/regex_utils.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/categoryWiseService/Topup/ui/widgets/top_bill_detail_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/enums/topup_type.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/utils/topup_utils.dart';

class MobileTopUpWidget extends StatefulWidget {
  final CategoryList categoryList;

  const MobileTopUpWidget({super.key, required this.categoryList});
  @override
  State<MobileTopUpWidget> createState() => _MobileTopUpWidgetState();
}

class _MobileTopUpWidgetState extends State<MobileTopUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final ValueNotifier<TopupType> _topUpType = ValueNotifier(TopupType.None);
  void updateTopupType(String number) {
    _topUpType.value = RegexUtils.checkPhoneNumberType(number);

    print(_topUpType.value);
  }

  @override
  void initState() {
    _mobileNumberController.addListener(() {
      updateTopupType(_mobileNumberController.text);
    });
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
      body: BlocListener<UtilityPaymentCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoading && _isLoading == false) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            }
          },
          child: CommonContainer(
            showDetail: true,
            showAccountSelection: true,
            accountTitle: "From Account",
            buttonName: "Proceed",
            topbarName: "Payment",
            title: "Mobile Top Up",
            detail: "Topup your mobile number.",
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          title: "Mobile Number",
                          hintText: "xxxxxxxxxx",
                          controller: _mobileNumberController,
                          validator: FormValidator.validatePhoneNumber,
                          suffixIcon: Icons.phone_android_outlined,
                          showSearchIcon: true,
                          onSuffixPressed: () async {
                            String phoneNumber =
                                await SecureStorageService.appPhoneNumber;
                            _mobileNumberController.text = phoneNumber;
                          },
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(6),
                      //   margin: const EdgeInsets.only(left: 8, top: 28),
                      //   height: _height * 0.06,
                      //   width: _width * 0.12,
                      //   child: SvgPicture.asset(
                      //     "assets/icons/Contact from phone.svg",
                      //   ),
                      // )
                    ],
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
            ),
            onButtonPressed: () {
              // context.read<UtilityPaymentCubit>().fetchDetails(
              //       serviceIdentifier: "worldlink_online_topup",
              //       accountDetails: {
              //         "wlink_username": "onine_renew"
              //       },
              //       apiEndpoint: "api/wlinkpackages",
              //     );
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                NavigationService.push(
                    target: TopUpBillDetailPage(
                        apiBody: {},
                        serviceIdentifier: TopUpUtils()
                            .getTopUpServiceType(type: _topUpType.value),
                        accountDetails: {
                          "account_number":
                              RepositoryProvider.of<CustomerDetailRepository>(
                                      context)
                                  .selectedAccount
                                  .value!
                                  .accountNumber,
                          "phone_number": _mobileNumberController.text,
                          "amount": _amountController.text
                        },
                        apiEndpoint: "/api/topup",
                        body: Column(
                          children: [
                            KeyValueTile(
                                title: "Mobile Number",
                                value: _mobileNumberController.text),
                            KeyValueTile(
                                title: "Amount", value: _amountController.text),
                          ],
                        ),
                        categoryList: widget.categoryList));
              }
              // NavigationService.push(target: CommonTransactionSuccessfulPage());
            },
          )),
    );
  }
}
