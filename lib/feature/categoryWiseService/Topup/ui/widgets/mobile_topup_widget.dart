import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/contact_utils.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';

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
  String currentAmount = '';
  List<ServiceList> selectedService = [];
  List<ServiceList> getTopupType(String phoneNumber) {
    if (phoneNumber.startsWith("+977")) {
      phoneNumber = phoneNumber.substring(4);
    }

    final String firstThreeDigits = phoneNumber.substring(0, 3);

    final List<ServiceList> services = widget.categoryList.services;

    final List<ServiceList> filteredServices = services.where((service) {
      final List<String> prefixes = service.labelPrefix.split(',');
      return prefixes.any((prefix) => prefix == firstThreeDigits);
    }).toList();
    selectedService = filteredServices;
    return filteredServices;
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
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
          onRecentTransactionPressed: (p0) {
            //  NavigationService.pop();
            _amountController.text = p0.amount.toString();
            _mobileNumberController.text = p0.serviceTo;
            setState(() {});
          },
          showRecentTransaction: true,
          showDetail: true,
          verificationAmount: currentAmount,
          showAccountSelection: true,
          accountTitle: LocaleKeys.accountTitle.tr(),
          buttonName: LocaleKeys.Proceed.tr(),
          topbarName: LocaleKeys.topup.tr(),
          title: LocaleKeys.title.tr(),
          detail: LocaleKeys.detail.tr(),
          serviceCategoryId: widget.categoryList.id.toString(),
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        suffixImage: "assets/icons/Contact from phone.svg",
                        title: LocaleKeys.mobileNumber.tr(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: "xxxxxxxxxx",
                        validator: (value) {
                          if (value!.startsWith("+977")) {
                            final newValue = value.substring(4);
                            return FormValidator.validatePhoneNumber(newValue);
                          } else {
                            return FormValidator.validatePhoneNumber(value);
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            final String newText = newValue.text
                                .replaceAll('+977', '')
                                .replaceAll('-', '');
                            return TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                          }),
                        ],
                        controller: _mobileNumberController,
                        suffixIcon: Icons.phone_android_outlined,
                        showSuffixImage: true,
                        textInputType: TextInputType.phone,
                        onSurffixImagePress: () async {
                          final String? pickedContact =
                              await ContactUtils.pickContact;

                          if (pickedContact != null) {
                            _mobileNumberController.text =
                                removeSpecificPatterns(pickedContact);
                            setState(() {});
                          }
                        },
                        onChanged: (value) {
                          if (value.length > 9) {
                            getTopupType(_mobileNumberController.text);
                            setState(() {});
                          }
                        },
                        showSearchIcon: true,
                        onSuffixPressed: () async {
                          final String phoneNumber =
                              await SecureStorageService.appPhoneNumber;
                          _mobileNumberController.text = phoneNumber;
                          getTopupType(phoneNumber);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                if (_mobileNumberController.text.length >= 10)
                  getTopupType(_mobileNumberController.text).isNotEmpty
                      ? Column(
                          children: [
                            Row(
                              children: [
                                CustomCachedNetworkImage(
                                    url: RepositoryProvider.of<CoOperative>(
                                                context)
                                            .baseUrl +
                                        "/ismart/serviceIcon/" +
                                        getTopupType(
                                                _mobileNumberController.text)
                                            .first
                                            .icon
                                            .toString(),
                                    height: 50.hp,
                                    fit: BoxFit.contain),
                                SizedBox(width: 20.wp),
                                Text(
                                    getTopupType(_mobileNumberController.text)
                                        .first
                                        .service
                                        .toString(),
                                    style: _textTheme.labelLarge!
                                        .copyWith(fontWeight: FontWeight.w700))
                              ],
                            ),
                            SizedBox(height: _height * 0.01),
                            CustomTextField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              title: LocaleKeys.amount.tr(), 
                              textInputType: TextInputType.number,
                              hintText: LocaleKeys.amountmoney.tr(),
                              controller: _amountController,
                              onChanged: (value) {
                                setState(() {
                                  currentAmount = value;
                                });
                              },
                              validator: (val) => FormValidator.validateAmount(
                                  val: val.toString(),
                                  maxAmount: selectedService.first.maxValue,
                                  minAmount: selectedService.first.minValue),
                            ),
                          ],
                        )
                      : Text(
                          "Service is currently unavailable",
                          style: _textTheme.labelMedium!.copyWith(
                            color: CustomTheme.googleColor,
                          ),
                        ),
              ],
            ),
          ),
          onButtonPressed: () {
            _formKey.currentState!.save();

            if (_formKey.currentState!.validate()) {
              final phoneNumber =
                  _mobileNumberController.text.startsWith("+977")
                      ? _mobileNumberController.text.substring(4)
                      : _mobileNumberController.text;
              if (selectedService.isNotEmpty)
                NavigationService.push(
                    target: CommonBillDetailPage(
                  serviceName: selectedService.first.service,
                  service: getTopupType(phoneNumber).first,
                  apiBody: const {},
                  serviceIdentifier:
                      getTopupType(phoneNumber).first.uniqueIdentifier,
                  accountDetails: {
                    "account_number":
                        RepositoryProvider.of<CustomerDetailRepository>(context)
                            .selectedAccount
                            .value!
                            .accountNumber,
                    "phone_number": phoneNumber,
                    "amount": _amountController.text
                  },
                  apiEndpoint: "/api/topup",
                  body: Column(
                    children: [
                      KeyValueTile(title: LocaleKeys.targetnumber.tr(), value: phoneNumber),
                      KeyValueTile(
                          title: LocaleKeys.amount.tr(), value: _amountController.text),
                    ],
                  ),
                ));
            }
          },
        ),
      ),
    );
  }

  String removeSpecificPatterns(String input) {
    if (input.startsWith('+977')) {
      input = input.substring(4);
    }
    input = input.replaceAll('-', '');
    return input;
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/app/theme.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/contact_utils.dart';
// import 'package:ismart/common/util/form_validator.dart';
// import 'package:ismart/common/util/regex_utils.dart';
// import 'package:ismart/common/util/secure_storage_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/common_text_field.dart';
// import 'package:ismart/common/widget/custom_cached_network_image.dart';
// import 'package:ismart/common/widget/key_value_tile.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/common/widget/show_loading_dialog.dart';
// import 'package:ismart/feature/categoryWiseService/Topup/ui/widgets/top_bill_detail_widget.dart';
// import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/enums/topup_type.dart';
// import 'package:ismart/feature/utility_payment/utils/topup_utils.dart';

// class MobileTopUpWidget extends StatefulWidget {
//   final CategoryList categoryList;

//   const MobileTopUpWidget({super.key, required this.categoryList});
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
//   bool showErrorMessage = false;
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
//           },
//           child: CommonContainer(
//             onRecentTransactionPressed: (p0) {
//               NavigationService.pop();
//               _amountController.text = p0.amount.toString();
//               _mobileNumberController.text = p0.serviceTo;
//               setState(() {});
//             },
//             showRecentTransaction: true,
//             showDetail: true,
//             showAccountSelection: true,
//             accountTitle: "From Account",
//             buttonName: "Proceed",
//             topbarName: "Payment",
//             title: "Mobile Top Up",
//             detail: "Topup your mobile number.",
//             serviceCategoryId: widget.categoryList.id.toString(),
//             body: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomTextField(
//                           suffixImage: "assets/icons/Contact from phone.svg",
//                           title: "Mobile Number",
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           hintText: "xxxxxxxxxx",
//                           controller: _mobileNumberController,
//                           validator: FormValidator.validatePhoneNumber,
//                           suffixIcon: Icons.phone_android_outlined,
//                           showSuffixImage: true,
//                           onSurffixImagePress: () async {
//                             final String? pickedContact =
//                                 await ContactUtils.pickContact;
//                             if (pickedContact != null) {
//                               _mobileNumberController.text = pickedContact;
//                               setState(() {});
//                             }
//                           },
//                           onChanged: (value) {
//                             // if (value.startsWith("+977")) {
//                             //   _mobileNumberController.value = TextEditingValue(
//                             //     text: value.substring(4),
//                             //     selection: TextSelection.collapsed(
//                             //         offset: value.length - 4),
//                             //   );
//                             if (value.length == 10) {
//                               final String topupType = TopUpUtils()
//                                   .getTopUpServiceType(type: _topUpType.value);
//                               TopUpUtils().getTopUpServiceImage(
//                                   type: topupType,
//                                   categories: widget.categoryList);
//                             }
//                             setState(() {});
//                             // }
//                           },
//                           showSearchIcon: true,
//                           onSuffixPressed: () async {
//                             final String phoneNumber =
//                                 await SecureStorageService.appPhoneNumber;
//                             _mobileNumberController.text = phoneNumber;
//                             TopUpUtils().getTopUpServiceImage(
//                                 type: TopUpUtils().getTopUpServiceType(
//                                     type: _topUpType.value),
//                                 categories: widget.categoryList);
//                             setState(() {});
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   if (_mobileNumberController.text.length == 10)
//                     Row(
//                       children: [
//                         CustomCachedNetworkImage(
//                             url: RepositoryProvider.of<CoOperative>(context)
//                                     .baseUrl +
//                                 "/ismart/serviceIcon/" +
//                                 TopUpUtils()
//                                     .getTopUpServiceImage(
//                                         type: TopUpUtils().getTopUpServiceType(
//                                             type: _topUpType.value),
//                                         categories: widget.categoryList)
//                                     .icon
//                                     .toString(),
//                             height: 50.hp,
//                             fit: BoxFit.contain),
//                         SizedBox(width: 20.wp),
//                         Text(
//                             TopUpUtils()
//                                 .getTopUpServiceImage(
//                                     type: TopUpUtils().getTopUpServiceType(
//                                         type: _topUpType.value),
//                                     categories: widget.categoryList)
//                                 .service
//                                 .toString(),
//                             style: _textTheme.labelLarge!
//                                 .copyWith(fontWeight: FontWeight.w700))
//                       ],
//                     ),
//                   if (showErrorMessage == true)
//                     Text(
//                       "Service is currently unavailable",
//                       style: _textTheme.labelMedium!.copyWith(
//                         color: CustomTheme.googleColor,
//                       ),
//                     ),
//                   SizedBox(height: _height * 0.01),
//                   CustomTextField(
//                     title: "Amount",
//                     textInputType: TextInputType.number,
//                     hintText: "Enter the amount",
//                     controller: _amountController,
//                     validator: (val) =>
//                         FormValidator.validateFieldNotEmpty(val, "Amount"),
//                   ),
//                 ],
//               ),
//             ),
//             onButtonPressed: () {
//               _formKey.currentState!.save();
//               if (TopUpUtils()
//                   .getTopUpServiceImage(
//                       type: TopUpUtils()
//                           .getTopUpServiceType(type: _topUpType.value),
//                       categories: widget.categoryList)
//                   .service
//                   .isEmpty) {
//                 showErrorMessage = true;

//                 setState(() {});
//               } else {
//                 if (_formKey.currentState!.validate()) {
//                   NavigationService.push(
//                       target: TopUpBillDetailPage(
//                           apiBody: const {},
//                           serviceIdentifier: TopUpUtils()
//                               .getTopUpServiceType(type: _topUpType.value),
//                           accountDetails: {
//                             "account_number":
//                                 RepositoryProvider.of<CustomerDetailRepository>(
//                                         context)
//                                     .selectedAccount
//                                     .value!
//                                     .accountNumber,
//                             "phone_number": _mobileNumberController.text,
//                             "amount": _amountController.text
//                           },
//                           apiEndpoint: "/api/topup",
//                           body: Column(
//                             children: [
//                               KeyValueTile(
//                                   title: "Mobile Number",
//                                   value: _mobileNumberController.text),
//                               KeyValueTile(
//                                   title: "Amount",
//                                   value: _amountController.text),
//                             ],
//                           ),
//                           categoryList: widget.categoryList));
//                 }
//               }
//             },
//           )),
//     );
//   }
// }
