import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class NetTvPaymentWidget extends StatefulWidget {
  final ServiceList service;

  const NetTvPaymentWidget({Key? key, required this.service}) : super(key: key);

  @override
  State<NetTvPaymentWidget> createState() => _NetTvPaymentWidgetState();
}

class _NetTvPaymentWidgetState extends State<NetTvPaymentWidget> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String? selectedDistrictValue;
  String? selectedProvinceValue;
  final bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showRecentTransaction: true,
        associatedId: widget.service.id.toString(),
        showAccountSelection: true,
        buttonName: "Show Bill",
        title: widget.service.service,
        detail: widget.service.instructions,
        showDetail: true,
        topbarName: widget.service.serviceCategoryName,
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Container(
              //       height: _height * 0.11,
              //       width: _width * 0.23,
              //       margin: const EdgeInsets.only(right: 18),
              //       child: Image.network(
              //           "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.service.icon}"),
              //     ),
              //     Expanded(
              //       child: Text(widget.service.service,
              //           style: Theme.of(context)
              //               .textTheme
              //               .titleLarge!
              //               .copyWith(fontWeight: FontWeight.w700)),
              //     ),
              //   ],
              // ),
              // SizedBox(height: _height * 0.02),
              CustomTextField(
                title: widget.service.labelName,
                hintText: "XXXXXXXXX",
                controller: usernameController,
                validator: (value) =>
                    FormValidator.validateFieldNotEmpty(value, "Username"),
              ),
              CustomTextField(
                title: "Amount",
                hintText: "NPR",
                controller: amountController,
                // validator: (value) => FormValidator.validateAmount(
                //     val: value.toString(),
                //     maxAmount: widget.service.maxValue,
                //     minAmount: widget.service.minValue.toDouble())),
              )
            ],
          ),
        ),
        onButtonPressed: () {
          if (_formKey.currentState!.validate()) {
            NavigationService.push(
                target: CommonBillDetailPage(
                    serviceName: widget.service.service,
                    body: Column(children: [
                      KeyValueTile(
                          title: "Username", value: usernameController.text),
                      KeyValueTile(
                          title: "Amount", value: amountController.text),
                    ]),
                    accountDetails: {
                      "amount": amountController.text,
                      "account_number":
                          RepositoryProvider.of<CustomerDetailRepository>(
                                  context)
                              .selectedAccount
                              .value!
                              .accountNumber,
                      "phone_number": usernameController.text
                    },
                    apiEndpoint: "/api/topup",
                    apiBody: const {},
                    service: widget.service,
                    serviceIdentifier: widget.service.uniqueIdentifier));
          }
        },
      ),
    );
  }
}

// NavigationService.push(target: TransactionPinScreen(
//   onValueCallback: (p0) {
//     NavigationService.pop();

//     context.read<UtilityPaymentCubit>().makePayment(
//         serviceIdentifier: widget.service.uniqueIdentifier,
//         // serviceIdentifier: "traffic_fine_payments",
//         apiEndpoint: "/api/tvpay",
//         body: {
//           "customerId ": usernameController.text
//         },
//         accountDetails: {
//           "account_number":
//               RepositoryProvider.of<CustomerDetailRepository>(
//                       context)
//                   .selectedAccount
//                   .value!
//                   .accountNumber
//                   .toString(),
//           "username": usernameController.text,
//           "customer_id": usernameController.text,
//           "amount": amountController.text,
//           // "account_number": "002001-001-102-0001010",

//           // "amount": myAmount,
//           // "amount": _response.findValue(
//           //     primaryKey: "hashResposne",
//           //     secondaryKey: "formattedFinalAmount"),
//           "mPin": p0
//         });
//   },
// ));
