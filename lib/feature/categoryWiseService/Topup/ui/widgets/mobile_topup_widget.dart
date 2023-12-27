import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/regex_utils.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/categoryWiseService/Topup/ui/widgets/top_bill_detail_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/enums/topup_type.dart';
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
  bool showErrorMessage = false;
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
            showRecentTransaction: true,
            showDetail: true,
            showAccountSelection: true,
            accountTitle: "From Account",
            buttonName: "Proceed",
            topbarName: "Payment",
            title: "Mobile Top Up",
            detail: "Topup your mobile number.",
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
                          title: "Mobile Number",
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hintText: "xxxxxxxxxx",
                          controller: _mobileNumberController,
                          validator: FormValidator.validatePhoneNumber,
                          suffixIcon: Icons.phone_android_outlined,
                          onChanged: (value) {
                            if (value.length == 10) {
                              final String topupType = TopUpUtils()
                                  .getTopUpServiceType(type: _topUpType.value);
                              TopUpUtils().getTopUpServiceImage(
                                  type: topupType,
                                  categories: widget.categoryList);
                            }
                            setState(() {});
                          },
                          showSearchIcon: true,
                          onSuffixPressed: () async {
                            // String? pickedContact =
                            //     await ContactUtils.pickContact;
                            // if (pickedContact != null) {
                            //   _mobileNumberController.text = pickedContact;
                            //   setState(() {});
                            // }
                            String phoneNumber =
                                await SecureStorageService.appPhoneNumber;
                            _mobileNumberController.text = phoneNumber;
                            TopUpUtils().getTopUpServiceImage(
                                type: TopUpUtils().getTopUpServiceType(
                                    type: _topUpType.value),
                                categories: widget.categoryList);
                            setState(() {});
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
                  if (_mobileNumberController.text.length == 10)
                    Row(
                      children: [
                        CustomCachedNetworkImage(
                            url: RepositoryProvider.of<CoOperative>(context)
                                    .baseUrl +
                                "/ismart/serviceIcon/" +
                                TopUpUtils()
                                    .getTopUpServiceImage(
                                        type: TopUpUtils().getTopUpServiceType(
                                            type: _topUpType.value),
                                        categories: widget.categoryList)
                                    .icon
                                    .toString(),
                            height: 50.hp,
                            fit: BoxFit.contain),
                        SizedBox(width: 20.wp),
                        Text(
                            TopUpUtils()
                                .getTopUpServiceImage(
                                    type: TopUpUtils().getTopUpServiceType(
                                        type: _topUpType.value),
                                    categories: widget.categoryList)
                                .service
                                .toString(),
                            style: _textTheme.labelLarge!
                                .copyWith(fontWeight: FontWeight.w700))
                      ],
                    ),
                  if (showErrorMessage == true)
                    Text(
                      "Service is currently unavailable",
                      style: _textTheme.labelMedium!.copyWith(
                        color: CustomTheme.googleColor,
                      ),
                    ),
                  SizedBox(height: _height * 0.01),
                  CustomTextField(
                    title: "Amount",
                    textInputType: TextInputType.number,
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
              _formKey.currentState!.save();
              if (TopUpUtils()
                  .getTopUpServiceImage(
                      type: TopUpUtils()
                          .getTopUpServiceType(type: _topUpType.value),
                      categories: widget.categoryList)
                  .service
                  .isEmpty) {
                showErrorMessage = true;

                setState(() {});
              } else {
                if (_formKey.currentState!.validate()) {
                  NavigationService.push(
                      target: TopUpBillDetailPage(
                          apiBody: const {},
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
                                  title: "Amount",
                                  value: _amountController.text),
                            ],
                          ),
                          categoryList: widget.categoryList));
                }
                // NavigationService.push(target: CommonTransactionSuccessfulPage());
              }
            },
          )),
    );
  }
}
