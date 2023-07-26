import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';

import 'package:ismart/common/util/size_utils.dart';

import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_error_dialog.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';

import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class KhanepaniDetailsWidgets extends StatefulWidget {
  final UtilityResponseData useServiceResponse;
  final String counterName;
  final String customerCode;
  final String counterCode;

  const KhanepaniDetailsWidgets({
    Key? key,
    required this.useServiceResponse,
    required this.counterName,
    required this.customerCode,
    required this.counterCode,
  }) : super(key: key);

  @override
  State<KhanepaniDetailsWidgets> createState() =>
      _KhanepaniDetailsWidgetsState();
}

class _KhanepaniDetailsWidgetsState extends State<KhanepaniDetailsWidgets> {
  final TextEditingController _amountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<String> _promoCode = ValueNotifier("");

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _amountController.text = widget.useServiceResponse
        .findValueString("total_dues", emptyString: "");
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UtilityPaymentCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoading && _isLoading == false) {
          _isLoading = true;
          showLoadingDialogBox(context);
        } else if (state is! CommonLoading && _isLoading) {
          _isLoading = false;
          Navigator.pop(context);
        }

        if (state is CommonStateSuccess<UtilityResponseData>) {
          // TODO Navigate to receipt
          // NavigationService.pushReplacement(
          //   target: ReceiptPage(
          //     receiableAmount: "${_amountController.text}",
          //     date: Jiffy(DateTime.tryParse(
          //                     state.data.findValueString("transaction_date"))
          //                 ?.toLocal() ??
          //             DateTime.now().toLocal())
          //         .format("yyyy-MM-dd"),
          //     transactionId: state.data.findValueString("transaction_id"),
          //     service: context.loc.khanepani.khanepani,
          //     userName: widget.customerCode,
          //     extras: {
          //       ...state.extras,
          //       "counterName": widget.counterName,
          //     },
          //     serviceId: widget.services.id,
          //     serviceTypeId: widget.services.serviceType.id,
          //   ),
          // );
        } else if (state is CommonError) {
          showWalletErrorDialogBox(
            context: context,
            message: state.message,
            errorCode: state.statusCode?.toString() ?? "",
          );
        }
      },
      child: PageWrapper(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonContainer(
                    body: Column(
                      children: [
                        KeyValueTile(
                          title: "Customer Code",
                          value: widget.useServiceResponse
                              .findValueString("customer_code"),
                        ),
                        KeyValueTile(
                          title: "Customer Name",
                          value: widget.useServiceResponse
                              .findValueString("customer_name"),
                        ),
                        KeyValueTile(
                          title: "Address",
                          value: widget.useServiceResponse
                              .findValueString("address"),
                        ),
                        KeyValueTile(
                          title: "Current Month Dues",
                          value: widget.useServiceResponse
                              .findValueString("current_month_dues"),
                        ),
                        KeyValueTile(
                          title: "Current Fine",
                          value: widget.useServiceResponse
                              .findValueString("current_month_fine"),
                        ),
                        KeyValueTile(
                          title: "Discount",
                          value: widget.useServiceResponse
                              .findValueString("current_month_discount"),
                        ),
                        KeyValueTile(
                          title: "Total Credit Sales Amount",
                          value: widget.useServiceResponse
                              .findValueString("total_credit_sales_amount"),
                        ),
                        KeyValueTile(
                          title: "Total Advance Amount",
                          value: widget.useServiceResponse
                              .findValueString("total_advance_amount"),
                        ),
                        KeyValueTile(
                          title: "Previous Dues",
                          value: widget.useServiceResponse
                              .findValueString("previous_dues"),
                          bottomPadding: 0,
                        ),
                      ],
                    ),
                    showDetail: true,
                    topbarName: 'Khanepani Payment',
                    buttonName: "Pay",
                    onButtonPressed: () {
                      // TODO call payment
                    },
                  ),
                  SizedBox(height: 20.wp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
