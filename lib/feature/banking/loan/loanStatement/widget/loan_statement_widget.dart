import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LoanStatementWidget extends StatefulWidget {
  LoanStatementWidget({Key? key}) : super(key: key);

  @override
  State<LoanStatementWidget> createState() => _LoanStatementWidgetState();
}

class _LoanStatementWidgetState extends State<LoanStatementWidget> {
  bool _isLoading = false;
  Future getMpin() async {
    String mPin = await SecureStorageService.appPassword;
    if (mPin.isNotEmpty) {
      context.read<UtilityPaymentCubit>().fetchDetails(
          serviceIdentifier: "",
          accountDetails: {
            "accountNumber":
                RepositoryProvider.of<CustomerDetailRepository>(context)
                    .selectedAccount
                    .value!
                    .accountNumber,
            "fromDate": "2020-01-01",
            "toDate": "2023-01-01",
            "mPin": mPin
          },
          apiEndpoint: "/api/loan/statement");
    }
    print("mmpin is $mPin");
  }

  @override
  void initState() {
    getMpin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
            verticalPadding: 0,
            horizontalPadding: 0,
            topbarName: "Loan Statement",
            showRoundBotton: false,
            showDetail: false,
            showTitleText: false,
            body: BlocBuilder<UtilityPaymentCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonStateSuccess<UtilityResponseData>) {
                  final _response = state.data.findValue(primaryKey: "data");
                  if (state.data.details.isNotEmpty) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: MaterialStatePropertyAll(
                            _theme.primaryColor.withOpacity(0.05)),
                        horizontalMargin: 10,
                        columnSpacing: 30.wp,
                        clipBehavior: Clip.hardEdge,
                        columns: [
                          DataColumn(
                            label: Text("SN"),
                          ),
                          DataColumn(
                            label: Text("Date"),
                          ),
                          DataColumn(
                            label: Expanded(child: Text("Issued \nAmount")),
                          ),
                          DataColumn(
                            label: Text("Principal"),
                          ),
                          DataColumn(
                            label: Text("Balance"),
                          ),
                        ],
                        rows: _response.map<DataRow>(
                          (e) {
                            final int index = _response.indexOf(e);
                            return DataRow(
                                color: MaterialStatePropertyAll(
                                  index.isOdd
                                      ? _theme.primaryColor.withOpacity(0.03)
                                      : CustomTheme.white,
                                ),
                                cells: [
                                  DataCell(
                                    Text("${index + 1}"),
                                  ),
                                  DataCell(
                                    Text(e["tranDate"].toString()),
                                  ),
                                  DataCell(
                                    Text(
                                      e["issuedAmount"].toString(),
                                      style: TextStyle(
                                          color: CustomTheme.googleColor),
                                    ),
                                  ),
                                  DataCell(
                                    Text(e["principal"].toString()),
                                  ),
                                  DataCell(
                                    Text(e["balance"].toString()),
                                  ),
                                ]);
                          },
                        ).toList(),
                      ),
                    );

                    // ),
                  } else {
                    return NoDataScreen(
                        title: "No Data Found",
                        details: "You don't have any transaction yet.");
                  }
                } else {
                  return Container(
                    child: Center(
                      child: Image.asset(
                          RepositoryProvider.of<CoOperative>(context)
                              .coOperativeLogo),
                    ),
                  );
                }
              },
            )));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/app/theme.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/secure_storage_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/no_data_screen.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/common/widget/show_loading_dialog.dart';
// import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

// class LoanStatementWidget extends StatefulWidget {
//   LoanStatementWidget({Key? key}) : super(key: key);

//   @override
//   State<LoanStatementWidget> createState() => _LoanStatementWidgetState();
// }

// class _LoanStatementWidgetState extends State<LoanStatementWidget> {
//   bool _isLoading = false;
//   Future getMpin() async {
//     String mPin = await SecureStorageService.appPassword;
//     if (mPin.isNotEmpty) {
//       context.read<UtilityPaymentCubit>().fetchDetails(
//           serviceIdentifier: "",
//           accountDetails: {
//             "accountNumber":
//                 RepositoryProvider.of<CustomerDetailRepository>(context)
//                     .selectedAccount
//                     .value!
//                     .accountNumber,
//             "fromDate": "2020-01-01",
//             "toDate": "2023-01-01",
//             "mPin": mPin
//           },
//           apiEndpoint: "/api/loan/statement");
//     }
//     print("mmpin is $mPin");
//   }

//   @override
//   void initState() {
//     getMpin();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     return PageWrapper(
//         body: CommonContainer(
//             verticalPadding: 0,
//             horizontalPadding: 0,
//             topbarName: "Loan Statement",
//             showRoundBotton: false,
//             showDetail: false,
//             showTitleText: false,
//             body: Column(children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 6,
//                 ),
//                 decoration: BoxDecoration(
//                   color: _theme.primaryColor.withOpacity(0.2),
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8)),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                         width: 20.wp,
//                         child: Center(
//                           child: Text(
//                             "SN",
//                             style: _textTheme.labelMedium,
//                           ),
//                         )),
//                     Expanded(
//                         child: Center(
//                       child: Text(
//                         "Date",
//                         style: _textTheme.labelMedium,
//                       ),
//                     )),
//                     Expanded(
//                         child: Center(
//                       child: Text(
//                         "Issued Amount",
//                         style: _textTheme.labelMedium,
//                       ),
//                     )),
//                     Expanded(
//                         child: Center(
//                       child: Text(
//                         "Principal",
//                         style: _textTheme.labelMedium,
//                       ),
//                     )),
//                     Expanded(
//                         child: Center(
//                       child: Text(
//                         "Balance",
//                         style: _textTheme.labelMedium,
//                       ),
//                     )),
//                   ],
//                 ),
//               ),
//               BlocBuilder<UtilityPaymentCubit, CommonState>(
//                 builder: (context, state) {
//                   if (state is CommonStateSuccess<UtilityResponseData>) {
//                     final _response = state.data.findValue(primaryKey: "data");
//                     if (state.data.details.isNotEmpty) {
//                       return Column(
//                         children: [
//                           ...List.generate(state.data.details.length, (index) {
//                             return Container(
//                               padding: EdgeInsets.symmetric(vertical: 2),
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: CustomTheme.darkerBlack)),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                       width: 20.wp,
//                                       child: Center(
//                                         child: Text(
//                                           (index + 1).toString(),
//                                           style: _textTheme.labelMedium,
//                                         ),
//                                       )),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                                 child: Text(
//                                               "${_response[index]["tranDate"].toString()}",
//                                               style: _textTheme.labelMedium,

//                                               // \n${_response[index]["scheduleDateNepali"]
//                                             )),
//                                             Expanded(
//                                                 child: Center(
//                                               child: Text(
//                                                 _response[index]["issuedAmount"]
//                                                     .toString(),
//                                                 style: _textTheme.labelMedium,
//                                               ),
//                                             )),
//                                             Expanded(
//                                                 child: Center(
//                                               child: Text(
//                                                 _response[index]["principal"]
//                                                     .toString(),
//                                                 style: _textTheme.labelMedium,
//                                               ),
//                                             )),
//                                             Expanded(
//                                                 child: Center(
//                                               child: Text(
//                                                 _response[index]["interest"]
//                                                     .toString(),
//                                                 style: _textTheme.labelMedium,
//                                               ),
//                                             )),
//                                           ],
//                                         ),
//                                         Text(
//                                           "${_response[index]["statementReference"].toString()}",
//                                           style: _textTheme.labelMedium,

//                                           // \n${_response[index]["scheduleDateNepali"]
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           })
//                         ],
//                       );
//                     } else {
//                       return Container();
//                     }
//                   } else {
//                     return Container();
//                   }
//                 },
//               )
//             ])));
//   }
// }
