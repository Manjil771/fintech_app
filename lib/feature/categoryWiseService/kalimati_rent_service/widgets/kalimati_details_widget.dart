// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/secure_storage_service.dart';
// import 'package:ismart/common/widget/common_bill_details_screen.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/key_value_tile.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

// class KalimatiDetailsWidget extends StatefulWidget {
//   final UtilityResponseData data;
//   final ServiceList service;
//   const KalimatiDetailsWidget(
//       {super.key, required this.data, required this.service});

//   @override
//   State<KalimatiDetailsWidget> createState() => _KalimatiDetailsWidgetState();
// }

// class _KalimatiDetailsWidgetState extends State<KalimatiDetailsWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final payload = widget.data.detail?['payload'] ?? {};
//     return PageWrapper(
//       body: CommonContainer(
//         topbarName: 'Rent Detail',
//         buttonName: "Pay",
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 12.0),
//               child: Text(
//                 "Rent Details",
//                 style: _textTheme.titleLarge!.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 KeyValueTile(
//                     title: "Trader Name", value: payload['traderName'] ?? '-'),
//                 KeyValueTile(
//                     title: "Shop ID",
//                     value: payload['shopIdentification'] ?? '-'),
//                 KeyValueTile(
//                     title: "Invoice Due Date",
//                     value: payload['invoiceDueDate'] ?? '-'),
//                 KeyValueTile(
//                   title: "Base Rent Amount",
//                   value: payload['baseRentAmount'] ?? '-',
//                 ),
//                 KeyValueTile(
//                   title: "Late Fee Amount",
//                   value: payload['lateFeeAmount'] ?? '-',
//                 ),
//                 KeyValueTile(
//                   title: "Other Amount",
//                   value: payload['otherAmount'] ?? '-',
//                 ),
//                 KeyValueTile(
//                   title: "Adjusted Amount",
//                   value: payload['adjustedAmount'] ?? '-',
//                 ),
//                 KeyValueTile(
//                   title: "Total Amount",
//                   value: payload['totalAmount'] ?? '-',
//                   bottomPadding: 0,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         onButtonPressed: () {
//           // NavigationService.push(target: TransactionPinScreen(
//           //   onValueCallback: (p0) {
//           //     NavigationService.pop();

//           //     context.read<UtilityPaymentCubit>().makePayment(
//           //           mPin: p0,
//           //           serviceIdentifier: "",
//           //           accountDetails: {
//           //             'accountNo':
//           //                 RepositoryProvider.of<CustomerDetailRepository>(
//           //                         context)
//           //                     .selectedAccount
//           //                     .value!
//           //                     .accountNumber,
//           //           },
//           //           body: {
//           //             "referenceNumber": "${payload['invoiceNumber']}",
//           //             "shopId": "${payload['shopIdentification']}",
//           //             "customerMobileNumber":
//           //                 SecureStorageService.appPhoneNumber,
//           //             "amount": "${payload['totalAmount']}",
//           //             "sessionInfo": "${payload['sessionInfo']}",
//           //           },
//           //           apiEndpoint: "/api/kmdb/pay",
//           //         );
//           //   },
//           // ));
//           final payload = widget.data.detail?['payload'] ?? {};
//           NavigationService.push(
//             target: CommonBillDetailPage(
//               serviceName: "kalimati",
//               body: Column(children: [
//                 KeyValueTile(
//                     title: "Trader Name", value: payload['traderName'] ?? '-'),
//                 KeyValueTile(
//                     title: "Shop ID",
//                     value: payload['shopIdentification'] ?? '-'),
//                 KeyValueTile(
//                     title: "Invoice Due Date",
//                     value: payload['invoiceDueDate'] ?? '-'),
//                 KeyValueTile(
//                   title: "Base Rent Amount",
//                   value: payload['baseRentAmount'] ?? '-',
//                 ),
//                 KeyValueTile(
//                   title: "Late Fee Amount",
//                   value: payload['lateFeeAmount'] ?? '-',
//                 ),
//                 KeyValueTile(
//                   title: "Other Amount",
//                   value: payload['otherAmount'] ?? '-',
//                 ),
//                 KeyValueTile(
//                   title: "Adjusted Amount",
//                   value: payload['adjustedAmount'] ?? '-',
//                 ),
//                 KeyValueTile(
//                   title: "Total Amount",
//                   value: payload['totalAmount'] ?? '-',
//                   bottomPadding: 0,
//                 ),
//               ]),
//               accountDetails: {
//                 "accountNumber":
//                     RepositoryProvider.of<CustomerDetailRepository>(context)
//                         .selectedAccount
//                         .value
//                         ?.accountNumber,
//               },
//               apiBody: {
//                 "referenceNumber": "${payload['invoiceNumber']}",
//                 "shopId": "${payload['shopIdentification']}",
//                 "customerMobileNumber": SecureStorageService.appPhoneNumber,
//                 "amount": "${payload['totalAmount']}",
//                 "sessionInfo": "${payload['sessionInfo']}",
//               },
//               apiEndpoint: "/api/kmdb/pay",
//               service: widget.service,
//               serviceIdentifier: '',
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
