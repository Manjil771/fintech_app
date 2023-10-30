import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/history/cubit/receipt_download_cubit.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/widget/transaction_detail_alert_widget.dart';
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
  bool isFixedAmount = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    return PageWrapper(
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
                NavigationService.pop();
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
                  state.data.findValue(primaryKey: "merchant_id");
              if (state.data.findValueString("amount").toString() != "null") {
                isFixedAmount = true;
                amountController.text = state.data.findValueString("amount");
              }
              return CommonContainer(
                  showDetail: false,
                  buttonName: "Procced",
                  title: "Make Payment",
                  topbarName: "Payment",
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        RepositoryProvider.of<CoOperative>(context).baseUrl +
                            state.data.findValue(primaryKey: "imageUrl"),
                        height: _height * 0.05,
                      ),
                      CustomTextField(
                        readOnly: true,
                        controller: merchantNameController,
                        title: "Merchant Name",
                      ),
                      CustomTextField(
                        title: "Merchant Id",
                        controller: merchantIdController,
                      ),
                      CustomTextField(
                        title: "Amount",
                        controller: amountController,
                        readOnly: isFixedAmount,
                      ),
                      CustomTextField(
                        title: "Remarks",
                        controller: remarksController
                          ..text = widget.remarks ?? "",
                      ),
                    ],
                  ),
                  onButtonPressed: () {
                    final _icon = state.data
                        .findValue(primaryKey: "imageUrl")
                        .toString()
                        .replaceAll("/ismart/serviceIcon/", "");
                    NavigationService.pushReplacement(
                      target: CommonBillDetailPage(
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
                        apiBody: {},
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
                              title: "Remarks", value: remarksController.text),
                        ]),
                        apiEndpoint: "/api/qpay/payment",
                      ),
                    );
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
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
