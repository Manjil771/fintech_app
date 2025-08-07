import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/show_yesno_popupbox.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/allremittance_details_page.dart';

import 'package:ismart/feature/receiveMoney/remit/receiveRemit/widget/paymentrelationship.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class RemitteancePaymentWidget extends StatefulWidget {
  final String pinNo;
  final String id;
  final String token;
  const RemitteancePaymentWidget(
      {super.key, required this.id, required this.token, required this.pinNo});

  @override
  State<RemitteancePaymentWidget> createState() =>
      _RemitteancePaymentWidgetState();
}

class _RemitteancePaymentWidgetState extends State<RemitteancePaymentWidget> {
  Future<String> getPhoneNumber() async {
    return await SecureStorageService.appPhoneNumber;
  }

  List<Map<String, dynamic>> extractListFromState(
      CommonStateSuccess<UtilityResponseData> state, String key) {
    final rawList = state.data.findValue<List<dynamic>>(primaryKey: key);
    return List<Map<String, dynamic>>.from(rawList ?? []);
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
        print("this is pipeline ${widget.token} ${widget.id},${widget.pinNo}");
        final res = state.data.details;

        final relationships = extractListFromState(state, 'relationships');
        final relationshipTypes =
            extractListFromState(state, 'relationshipTypes');
        final purposes = extractListFromState(state, 'remittancePurposes');

        return CommonContainer(
          topbarName: "Payment",
          title: "Remittance Payment",
          detail: "Pay your remittance bill from here",
          buttonName: "Pay",
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              showYesNoPopUpDialog(
                context: context,
                title: "Confirm",
                message: "Do you want to proceed?",
                onYes: () {
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
                },
                onNo: () {
                  context.read<UtilityPaymentCubit>().fetchDetails(
                        serviceIdentifier: "",
                        accountDetails: {
                          "pinNo": widget.pinNo,
                          "payTokenId": widget.token,
                          "id": widget.id,
                        },
                        apiEndpoint: "api/remittance/receive/transactionUnlock",
                      );
                },
              );
            }
          },
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Relationship"),
                  title: "Relationship",
                  textInputType: TextInputType.number,
                  controller: relation,
                  onTap: () async {
                    final selectedRelation = await NavigationService.push(
                      target: SelectableListWidget(
                        title: "Realation",
                        items: relationships,
                        onItemSelected: (relationData) {
                          Navigator.pop(context,
                              relationData); // return the selected item
                        },
                      ),
                    );

                    if (selectedRelation != null) {
                      relation.text = selectedRelation['text'] ?? '';
                    }
                  },
                ),
                CustomTextField(
                  validator: (val) => FormValidator.validateFieldNotEmpty(
                      val, "Relationship Type"),
                  title: "Relationship Type",
                  textInputType: TextInputType.number,
                  controller: relationType,
                  onTap: () async {
                    final selectedRelation = await NavigationService.push(
                      target: SelectableListWidget(
                        title: "Relationship Type",
                        items: relationshipTypes,
                        onItemSelected: (relationData) {
                          Navigator.pop(context,
                              relationData); // return the selected item
                        },
                      ),
                    );

                    if (selectedRelation != null) {
                      relationType.text = selectedRelation['text'] ?? '';
                    }
                  },
                ),
                CustomTextField(
                  validator: (val) =>
                      FormValidator.validateFieldNotEmpty(val, "Purpose"),
                  title: "Purpose",
                  textInputType: TextInputType.number,
                  controller: puropse,
                  onTap: () async {
                    final selectedRelation = await NavigationService.push(
                      target: SelectableListWidget(
                        title: "Purpose",
                        items: purposes,
                        onItemSelected: (relationData) {
                          Navigator.pop(context,
                              relationData); // return the selected item
                        },
                      ),
                    );

                    if (selectedRelation != null) {
                      puropse.text = selectedRelation['text'] ?? '';
                    }
                  },
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
