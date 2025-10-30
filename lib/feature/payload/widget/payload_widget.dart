import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class PayloadWidget extends StatefulWidget {
  final String? payload;
  final String? remarks;
  const PayloadWidget({Key? key, this.payload, this.remarks}) : super(key: key);

  @override
  State<PayloadWidget> createState() => _PayloadWidgetState();
}

class _PayloadWidgetState extends State<PayloadWidget> {
  final TextEditingController merchantNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  final TextEditingController merchantIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isFixedAmount = false;
  bool _isLoading = false;
  String _currentAmount = '';
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    return PageWrapper(
      showBackButton: true,
      body: BlocConsumer<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && !_isLoading) {
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
                NavigationService.pushReplacement(
                    target: const DashboardPage());
              },
            );
          }
        },
        builder: (context, state) {
          if (state is CommonStateSuccess<UtilityResponseData>) {
            if (state.data.code == "M0000" &&
                state.data.status.toLowerCase() == "success") {
              merchantNameController.text =
                  state.data.findValue(primaryKey: "merchant_name");
              merchantIdController.text =
                  state.data.findValue(primaryKey: "merchant_id").toString();
              if (state.data.findValueString("amount").toString() != "null") {
                isFixedAmount = true;
                amountController.text = state.data.findValueString("amount");
              }
              return CommonContainer(
                  verificationAmount: _currentAmount,
                  showAccountSelection: true,
                  showDetail: false,
                  buttonName: "Procced",
                  title: "Make Payment",
                  topbarName: "Payment",
                  body: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomCachedNetworkImage(
                          url: RepositoryProvider.of<CoOperative>(context)
                                  .baseUrl +
                              state.data
                                  .findValue(primaryKey: "imageUrl")
                                  .toString(),
                          height: _height * 0.05,
                          fit: BoxFit.cover,
                          customPlaceHolder: Image.asset(
                              RepositoryProvider.of<CoOperative>(context)
                                  .coOperativeLogo),
                        ),
                        CustomTextField(
                          readOnly: true,
                          controller: merchantNameController,
                          title: "Merchant Name",
                        ),
                        CustomTextField(
                          readOnly: true,
                          title: "Merchant Id",
                          controller: merchantIdController,
                        ),
                        CustomTextField(
                          textInputType: TextInputType.number,
                          validator: (value) =>
                              FormValidator.validateFieldNotEmpty(
                                  value, "Amount"),
                          title: "Amount",
                          controller: amountController,
                          onChanged: (value) {
                            setState(() {
                              _currentAmount = value;
                            });
                          },
                          readOnly: isFixedAmount,
                        ),
                        CustomTextField(
                          validator: (value) =>
                              FormValidator.validateFieldNotEmpty(
                                  value, "Remarks"),
                          title: "Remarks",
                          controller: remarksController
                            ..text = widget.remarks ?? "",
                        ),
                      ],
                    ),
                  ),
                  onButtonPressed: () {
                    final _icon = state.data
                        .findValue(primaryKey: "imageUrl")
                        .toString()
                        .replaceAll("/ismart/serviceIcon/", "");
                    if (_formKey.currentState!.validate()) {
                      NavigationService.push(
                        target: CommonBillDetailPage(
                          serviceName: "QR Payment",
                          service: ServiceList(
                              url: Url.URL,
                              id: 0,
                              uniqueIdentifier: "fonepay",
                              service: "",
                              status: Status.ACTIVE,
                              labelName: "",
                              labelMaxLength: "",
                              labelMinLength: "",
                              labelSample: "",
                              labelPrefix: "",
                              instructions: "",
                              fixedlabelSize: true,
                              priceInput: true,
                              notificationUrl: "fonepay",
                              minValue: 0.0,
                              maxValue: 5000.0,
                              icon: _icon,
                              categoryId: 21,
                              serviceCategoryName: "",
                              webView: true,
                              isNew: true,
                              appOrder: 0,
                              isSmsMode: true),
                          apiBody: const {},
                          serviceIdentifier: "",
                          accountDetails: {
                            "pay_load": widget.payload,
                            "remarks": remarksController.text,
                            "account_number":
                                RepositoryProvider.of<CustomerDetailRepository>(
                                        context)
                                    .selectedAccount
                                    .value!
                                    .accountNumber,
                            "amount": amountController.text,
                          },
                          body: Column(children: [
                            KeyValueTile(
                                title: "Merchant Name",
                                value: merchantNameController.text),
                            KeyValueTile(
                                title: "Merchant Id",
                                value: merchantIdController.text),
                            KeyValueTile(
                                title: "Amount", value: amountController.text),
                            KeyValueTile(
                                title: "Remarks",
                                value: remarksController.text),
                          ]),
                          apiEndpoint: "/api/qpay/payment",
                        ),
                      );
                    }
                  });
            } else {
              return Column(
                children: [
                  NoDataScreen(title: "", details: state.data.message),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomRoundedButtom(
                        title: "Close",
                        onPressed: () {
                          NavigationService.pop();
                        }),
                  )
                ],
              );
              //  showPopUpDialog(
              //   context: context,
              //   message: state.data.message,
              //   title: "Exception",
              //   buttonCallback: () {
              //     NavigationService.pop();
              //   },
              // );
            }
          }
          if (state is CommonLoading) {
            return const CommonLoadingWidget();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
