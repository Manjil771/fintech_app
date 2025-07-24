import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/receive_remittance_page.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/paymentrelationship.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class RemitteancePaymentWidget extends StatefulWidget {
  final int id;
  const RemitteancePaymentWidget({super.key, required this.id});

  @override
  State<RemitteancePaymentWidget> createState() =>
      _RemitteancePaymentWidgetState();
}

class _RemitteancePaymentWidgetState extends State<RemitteancePaymentWidget> {
  Future<String> getPhoneNumber() async {
    return await SecureStorageService.appPhoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController relation = TextEditingController();
    final TextEditingController relationType = TextEditingController();
    final TextEditingController puropse = TextEditingController();
    return PageWrapper(body: BlocBuilder<UtilityPaymentCubit, CommonState>(
        builder: (context, state) {
      if (state is CommonStateSuccess<UtilityResponseData>) {
        final res = state.data.details;
        print("This is data :${res.first} ");
        final relationshipRawList = state.data
            .findValue<List<dynamic>>(primaryKey: 'relationshipTypes');
        final List<Map<String, dynamic>> relationships =
            List<Map<String, dynamic>>.from(relationshipRawList ?? []);

        // final relationshipList = (res["details"] as List);

        print("this is relationship$relationships");
        return CommonContainer(
          topbarName: "Payment",
          title: "Remittance Payment",
          detail: "Pay your remittance bill from here",
          buttonName: "Pay",
          onButtonPressed: () {
            NavigationService.push(target: TransactionPinScreen(
              onValueCallback: (p0) {
                NavigationService.pop();

                context.read<UtilityPaymentCubit>().makePayment(
                  mPin: p0,
                  serviceIdentifier: "",
                  // serviceIdentifier: "traffic_fine_payments",
                  apiEndpoint: "remittance/payTransactionConfirm",
                  body: {},
                  accountDetails: {
                    "id": widget.id,
                    "relationship": relation.text,
                    "relationshipType": relationType.text,
                    "remittancePurpose": puropse.text,
                    // "mobileNumber":
                    //     RepositoryProvider.of<CustomerDetailRepository>(context)
                    //         .customerDetailModel
                    //         .value
                    //         ?.mobileNumber,
                  },
                );
              },
            ));

            // onButtonPressed();
            // NavigationService.push(
            //   target: RemittanceDetailsFetchPage(
            //     imagePath: widget.imagePath,
            //     bankName: widget.bankName,
            //     data: const {
            //       "details": {
            //         "receiverName": "NISHAN THAPA",
            //         "receiverMobileNumber": "9869191849",
            //         "receiverCity": "KATHMANDU",
            //         "receiverCountary": "NPL",
            //         "senderName": "SHYAM BDR THAPA",
            //         "senderCountary": "JPN",
            //         "pinNo": "66621470641",
            //         "payoutAmount": "2552.0000",
            //         "payoutCurrency": "NPR",
            //         "payoutType": "Cash Pay",
            //         "txnDate": "2025-05-30 14:56:48.340",
            //         "tokenId": "460341",
            //       }
            //     },
            //   ),
            // );
          },
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  title: "Relationship",
                  hintText: "xxxxxxxxxx",
                  textInputType: TextInputType.number,
                  controller: relation,
                  onTap: () {
                    NavigationService.push(
                        target: RelationshipListWidget(
                      relationships: relationships,
                      onRelationshipSelected: (relation) {
                        // Handle selected relationship
                        print("Selected: ${relation['text']}");
                        Navigator.pop(
                            context, relation); // or do any action you want
                      },
                    ));
                  },
                ),
                CustomTextField(
                  title: "Relationship Type",
                  hintText: "xxxxxxxxxx",
                  textInputType: TextInputType.number,
                  controller: relationType,
                ),
                CustomTextField(
                  title: "Purpose",
                  hintText: "xxxxxxxxxx",
                  textInputType: TextInputType.number,
                  controller: puropse,
                )
              ],
            ),
          ),
        );
      } else if (state is CommonLoading) {
        return const CommonLoadingWidget();
      } else {
        return const NoDataScreen(
          title: "Not Found",
          details: "No remittance records available.",
        );
      }
    }));
  }
}
