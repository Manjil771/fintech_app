import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/regex_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/enums/topup_type.dart';
import 'package:ismart/feature/utility_payment/utils/topup_utils.dart';

class MobileTopUpWidget extends StatefulWidget {
  @override
  State<MobileTopUpWidget> createState() => _MobileTopUpWidgetState();
}

class _MobileTopUpWidgetState extends State<MobileTopUpWidget> {
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
            title: "Mobile Top Up",
            detail: "Load money to your preferred eSewa account.",
            body: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        title: "Mobile Number",
                        hintText: "xxxxxxxxxx",
                        controller: _mobileNumberController,
                        validator: FormValidator.validatePhoneNumber,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.only(left: 8, top: 28),
                      height: _height * 0.06,
                      width: _width * 0.12,
                      child: SvgPicture.asset(
                        "assets/icons/Contact from phone.svg",
                      ),
                    )
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
            onButtonPressed: () {
              // context.read<UtilityPaymentCubit>().fetchDetails(
              //       serviceIdentifier: "worldlink_online_topup",
              //       accountDetails: {
              //         "wlink_username": "onine_renew"
              //       },
              //       apiEndpoint: "api/wlinkpackages",
              //     );
              NavigationService.push(
                target: TransactionPinScreen(
                  onValueCallback: (mpin) {
                    NavigationService.pop();
                    context.read<UtilityPaymentCubit>().getTopUp(
                          serviceIdentifier: TopUpUtils()
                              .getTopUpServiceType(type: _topUpType.value),
                          accountNumber: RepositoryProvider.of<
                                  CustomerDetailRepository>(context)
                              .accountsList
                              .value
                              .first
                              .accountNumber, // TODO Update dynamic account number
                          phoneNumber: _mobileNumberController.text,
                          amount: _amountController.text,
                          mpin: mpin,
                        );
                  },
                ),
              );
            },
          )),
    );
  }

  // amountBox(context, index) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(color: Colors.black),
  //     ),
  //     child: Center(child: Text(amount[index].toString())),
  //   );
  // }

  // final List amount = [100, 200, 500, 1000, 2000, 5000];
}
/// TODO Delete below old code
// Expanded(
// child: SvgPicture.asset(
// "assets/icons/Contact from phone.svg"))
// Padding(
//           padding: const EdgeInsets.all(24),
//           child: ListView(
//             children: [
//               Form(
//                 child: Container(
//                   padding: const EdgeInsets.all(24),
//                   color: Colors.white,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         "Mobile Top Up",
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       Text(
//                         "Load balance to your mobile number.",
//                         style: Theme.of(context).textTheme.displaySmall,
//                       ),
//                       SizedBox(height: _height * 0.01),
//                       Text(
//                         "Select Account",
//                         style: Theme.of(context).textTheme.titleMedium,
//                       ),

//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomTextField(
//                               title: "Mobile Number",
//                               hintText: "xxxxxxxxxx",
//                               controller: _mobileNumberController,
//                               validator: FormValidator.validatePhoneNumber,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(6),
//                             margin: const EdgeInsets.only(left: 8, top: 28),
//                             height: _height * 0.06,
//                             width: size.width * 0.12,
//                             child: SvgPicture.asset(
//                               "assets/icons/Contact from phone.svg",
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: size.height * 0.01),
//                       CustomTextField(
//                         title: "Amount",
//                         hintText: "Enter the amount",
//                         controller: _amountController,
//                         validator: (val) =>
//                             FormValidator.validateFieldNotEmpty(val, "Amount"),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.only(top: 7),
//                         height: size.height * 0.12,
//                         width: double.infinity,
//                         child: GridView.builder(
//                           itemCount: 6,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   childAspectRatio: 1.4 / 0.6),
//                           itemBuilder: (context, index) =>
//                               amountBox(context, index),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.04),
//                       CustomRoundedButtom(
//                         title: "Done",
//                         onPressed: () {
//                           // context.read<UtilityPaymentCubit>().fetchDetails(
//                           //       serviceIdentifier: "worldlink_online_topup",
//                           //       accountDetails: {
//                           //         "wlink_username": "onine_renew"
//                           //       },
//                           //       apiEndpoint: "api/wlinkpackages",
//                           //     );
//                           NavigationService.push(
//                             target: TransactionPinScreen(
//                               onValueCallback: (mpin) {
//                                 NavigationService.pop();
//                                 context.read<UtilityPaymentCubit>().getTopUp(
//                                       serviceIdentifier: TopUpUtils()
//                                           .getTopUpServiceType(
//                                               type: _topUpType.value),
//                                       accountNumber: RepositoryProvider.of<
//                                               CustomerDetailRepository>(context)
//                                           .accountsList
//                                           .value
//                                           .first
//                                           .accountNumber, // TODO Update dynamic account number
//                                       phoneNumber: _mobileNumberController.text,
//                                       amount: _amountController.text,
//                                       mpin: mpin,
//                                     );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                       SizedBox(height: size.height * 0.04),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Recent Transaction",
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               "View All",
//                               style: TextStyle(
//                                 color: Theme.of(context).primaryColor,
//                                 fontFamily: "popinmedium",
//                                 fontSize: 16,
//                               ),
//                             ),
//                           )
//                         ],
//                       )
//                       // ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),