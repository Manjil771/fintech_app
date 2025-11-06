import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_transaction_success_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class RemittanceDetailFetchWidget extends StatefulWidget {
  final UtilityResponseData data;
  final String path;
  final String bankName;

  const RemittanceDetailFetchWidget(
      {Key? key,
      required this.data,
      required this.path,
      required this.bankName})
      : super(key: key);

  @override
  State<RemittanceDetailFetchWidget> createState() => _RemittanceDetailFetchWidgetState();
}

class _RemittanceDetailFetchWidgetState extends State<RemittanceDetailFetchWidget> {

  final ValueNotifier<bool> ispayment = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;

    return PageWrapper(
      showBackButton: true,
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state){
           if (state is CommonLoading ) { 
                showLoadingDialogBox(context);
              } else if (state is! CommonLoading ) {
                NavigationService.pop();
              }
        if (state is CommonStateSuccess<UtilityResponseData> && !ispayment.value) {
          final UtilityResponseData response = state.data;
          if (response.code == "M0000") {
        final List response = state.data.findValue(primaryKey: "data") as List;
        //  final pinNovalue = response.where((item) => item["pinNo"] == data.details.firstWhere((val)=> val.title == 'pinNo').value);
        final pinNoValue = widget.data.details.firstWhere((val)=> val.title == 'pinNo').value;
        final matchedItem = response.firstWhere(
        (item) => item["pinNo"] == pinNoValue,
        orElse: () => null,
         ); 
        if(matchedItem != null){
        final id = matchedItem["id"]; 
        setState(() {
             ispayment.value = true;
        });
         NavigationService.push(target: TransactionPinScreen(
          valuenotify:ispayment,
                          onValueCallback: (p0) {
                            NavigationService.pop();
                            context.read<UtilityPaymentCubit>().makePayment(
                                  mPin: p0,
                                  serviceIdentifier: '',
                                  apiEndpoint: 'api/remittance/payTransactionConfirm',
                                  body: {
                                  },
                                  accountDetails: {
                            "id" : id.toString(),
                            "relationship": "Aunty",
                            "relationshipType": "Father",
                            "remittancePurpose" : "Business",
                            "mobileNumber" : '${RepositoryProvider.of<CustomerDetailRepository>(
                                          context).customerDetailModel.value?.mobileNumber ?? ''}'  
                                  },
                                );
                          },
                        ),
                        );
        }else{
           showPopUpDialog(
                showCancelButton: false,
                context: context,
                message: "There is no equivalent remittance status.",
                title: "Error",
                buttonCallback: () {
                  NavigationService.pop();
                });
        }
          }
           else {
            print("this is msg $response.message");
            showPopUpDialog(
                showCancelButton: false,
                context: context,
                message: response.message,
                title: response.status,
                buttonCallback: () {
                          setState(() {
             ispayment.value = false;
              });
                  NavigationService.pop();
                });
          }
        }else if (state is CommonStateSuccess<UtilityResponseData> && ispayment.value){
              final UtilityResponseData _response = state.data;
            if (_response.code == "M0000" ||
                _response.status.toLowerCase() == "M0000" ||
                _response.status.toLowerCase() == "success" ||
                _response.message
                    .toLowerCase()
                    .contains("success".toLowerCase())) {
              NavigationService.pushReplacement(
                  target: CommonTransactionSuccessPage(
                    transactionID: '',
                    serviceName: "Remittance",
                      // serviceName: widget.service.service,
                      // arrival: widget.arrivalFlight,
                      // departure: widget.departureFlight,
                      // pdfUrl:
                      //     state.data.findValue(primaryKey: "airlinesPdfUrl"),
                      // transactionID: state.data.transactionIdentifier,
                      body: Container(),
                      message: state.data.message,
                      service: ServiceList(
                              url: Url.URL,
                              id: 0,
                              uniqueIdentifier: "remittance",
                              service: "Remittance",
                              status: Status.ACTIVE,
                              labelName: "Remittance",
                              labelMaxLength: "",
                              labelMinLength: "",
                              labelSample: "",
                              labelPrefix: "",
                              instructions: "",
                              fixedlabelSize: true,
                              priceInput: true,
                              notificationUrl: "remittance",
                              minValue: 0.0,
                              maxValue: 0.0,
                              icon: '',
                              categoryId: 0,
                              serviceCategoryName: "",
                              webView: true,
                              isNew: true,
                              appOrder: 0,
                              isSmsMode: true),
                      
                      
                      ));
            } else {
              showPopUpDialog(
                context: context,
                message: _response.message,
                title: _response.status,
                showCancelButton: false,
                buttonCallback: () {
                    setState(() {
             ispayment.value = false;
              });
                  NavigationService.pop();
                },
              );
            }
          
        }
        
         else if (state is CommonError) {
          showPopUpDialog(
              showCancelButton: false,
              context: context,
              message: state.message,
              title: "Error",
              buttonCallback: () {
                        setState(() {
             ispayment.value = false;
              });
                NavigationService.pop();
              });
        }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    widget.path,
                    height: _height * 0.08,
                  ),
                  SizedBox(height: _height * 0.02),
                  Text(
                    widget.bankName,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: _height * 0.02),
                  Text(
                      "Details about the payable amount for the service of   is shown below.",
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
                        Text("Transaction Details",
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: _height * 0.02),
                        KeyValueTile(
                            title: "Receiver Name",
                            value: widget.data.details
                                    .firstWhere(
                                        (val) => val.title == 'receiverName')
                                    .value ??
                                ""),
                        KeyValueTile(
                            title: "Receiver Mobile Number",
                            value: widget.data.details
                                    .firstWhere((val) =>
                                        val.title == 'receiverMobileNumber')
                                    .value ??
                                ""),
                        KeyValueTile(
                            title: "Receiver City",
                            value: widget.data.details
                                    .firstWhere(
                                        (val) => val.title == 'receiverCity')
                                    .value ??
                                ""),
                        KeyValueTile(
                            title: "Receiver Country",
                            value: widget.data.details
                                    .firstWhere(
                                        (val) => val.title == 'receiverCountary')
                                    .value ??
                                ""),
                        KeyValueTile(
                            title: "Sender Name",
                            value: widget.data.details
                                    .firstWhere(
                                        (val) => val.title == 'senderName')
                                    .value ??
                                ""),
                        KeyValueTile(
                            title: "Sender Country",
                            value: widget.data.details
                                    .firstWhere(
                                        (val) => val.title == 'senderCountary')
                                    .value ??
                                ""),
                        // KeyValueTile(
                        //     title: "PIN No",
                        //     value: data.details
                        //             .firstWhere((val) => val.title == 'pinNo')
                        //             .value ??
                        //         ""),
                        KeyValueTile(
                            title: "Payout Amount",
                            value: widget.data.details
                                    .firstWhere(
                                        (val) => val.title == 'payoutAmount')
                                    .value ??
                                ""),
                        KeyValueTile(
                            title: "Payout Currency",
                            value: widget.data.details
                                    .firstWhere(
                                        (val) => val.title == 'payoutCurrency')
                                    .value ??
                                ""),
                        KeyValueTile(
                            title: "Payout Type",
                            value: widget.data.details
                                    .firstWhere(
                                        (val) => val.title == 'payoutType')
                                    .value ??
                                ""),
                        KeyValueTile(
                            title: "Transaction Date",
                            value: widget.data.details
                                    .firstWhere((val) => val.title == 'txnDate')
                                    .value ??
                                ""),
                      ],
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  CustomRoundedButtom(
                      title: "Procced",
                      onPressed: () {
                        // NavigationService.push(
                        //     // target: const AllremittanceDetailsPage(),
                        //     target: Container());()
                        onButtonPressed(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }

 void onButtonPressed(BuildContext context) {
    context.read<UtilityPaymentCubit>().fetchDetails(
          serviceIdentifier: "",
          accountDetails: {
            // "id" : id,
            // "relationship": "Aunty",
            // "relationshipType": "Father",
            // "remittancePurpose" : "Business",
            // "mobileNumber" : '${RepositoryProvider.of<CustomerDetailRepository>(
            //                               context).customerDetailModel.value?.mobileNumber ?? ''}'
           
          },
          apiEndpoint: "api/remittance/getAllRemittance",
        );
  }

  Widget _buildRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120,
              child: Text("$title:",
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
              child: Text(value ?? "-",
                  style: const TextStyle(fontWeight: FontWeight.normal))),
        ],
      ),
    );
  }
}
