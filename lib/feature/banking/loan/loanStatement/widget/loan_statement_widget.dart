import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LoanStatementWidget extends StatefulWidget {
  @override
  State<LoanStatementWidget> createState() => _LoanStatementWidgetState();
}

class _LoanStatementWidgetState extends State<LoanStatementWidget> {
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 90));
  DateTime toDate = DateTime.now();
  @override
  void initState() {
    fetchLoanStatement(
      fromDate: fromDate,
      toDate: toDate,
    );
    super.initState();
  }

  fetchLoanStatement(
      {required DateTime fromDate, required DateTime toDate}) async {
    final String mPin = await SecureStorageService.appPassword;
    context.read<UtilityPaymentCubit>().fetchDetails(
        serviceIdentifier: "",
        accountDetails: {
          "accountNumber":
              RepositoryProvider.of<CustomerDetailRepository>(context)
                  .selectedAccount
                  .value!
                  .accountNumber,
          "mPin": mPin,
          "fromDate": DateFormat("yyyy-MM-dd").format(fromDate),
          "toDate": DateFormat("yyyy-MM-dd").format(toDate),
        },
        apiEndpoint: "api/loan/statement");
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
        body: Column(
          children: [
            BlocBuilder<UtilityPaymentCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonStateSuccess) {
                  final UtilityResponseData response = state.data;
                  final _response = response.findValue(primaryKey: "data");
                  return response.details.isNotEmpty
                      ? Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                headingRowColor: MaterialStatePropertyAll(
                                    _theme.primaryColor.withOpacity(0.05)),
                                columnSpacing: 10,
                                columns: const [
                                  DataColumn(label: Text('SN')),
                                  DataColumn(
                                      label: Text(
                                    'Tranaction \nDate',
                                    textAlign: TextAlign.center,
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Interest\nDate',
                                    textAlign: TextAlign.center,
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Issued\nAmount',
                                    textAlign: TextAlign.center,
                                  )),
                                  DataColumn(label: Text('Payment')),
                                  DataColumn(label: Text('Principal')),
                                  DataColumn(label: Text('Interest')),
                                  DataColumn(label: Text('Fine')),
                                  DataColumn(label: Text('Discount')),
                                  DataColumn(label: Text('Balance')),
                                  DataColumn(
                                      label: Text('Statement Reference')),
                                ],
                                rows: List.generate(
                                  _response,
                                  (index) => DataRow(
                                      color: MaterialStatePropertyAll(
                                          index.isEven
                                              ? CustomTheme.white
                                              : _theme.primaryColor
                                                  .withOpacity(0.03)),
                                      cells: [
                                        DataCell(Text("${index + 1}")),
                                        DataCell(Text(_response[index]
                                                ['tranDate'] ??
                                            '')),
                                        DataCell(Text(_response[index]
                                                ['interestDate']
                                            .toString())),
                                        DataCell(Text(_response[index]
                                                ['issuedAmount']
                                            .toString())),
                                        DataCell(Text(_response[index]
                                                ['payment']
                                            .toString())),
                                        DataCell(Text(_response[index]
                                                ['principal']
                                            .toString())),
                                        DataCell(Text(_response[index]
                                                ['interest']
                                            .toString())),
                                        DataCell(Text(_response[index]['fine']
                                            .toString())),
                                        DataCell(Text(_response[index]
                                                ['discount']
                                            .toString())),
                                        DataCell(Text(_response[index]
                                                ['balance']
                                            .toString())),
                                        DataCell(SizedBox(
                                          width: 30.w,
                                          child: Text(_response[index]
                                                  ['statementReference']
                                              .toString()),
                                        )),
                                      ]),
                                ),
                              ),
                            ),
                            //     Container(
                            //       height: 60.hp,
                            //       color: _theme.primaryColor.withOpacity(0.05),
                            //       child: Row(children: [
                            //         Flexible(
                            //           flex: 1,
                            //           child: Container(
                            //             child: Center(
                            //                 child: Text(
                            //               "SN",
                            //               style: _textTheme.headlineSmall!
                            //                   .copyWith(fontSize: 12),
                            //             )),
                            //           ),
                            //         ),
                            //         Flexible(
                            //           flex: 10,
                            //           child: Row(
                            //             children: [
                            //               Flexible(
                            //                 flex: 1,
                            //                 child: Center(
                            //                   child: Text(
                            //                     "Date",
                            //                     style: _textTheme.headlineSmall!
                            //                         .copyWith(fontSize: 12),
                            //                   ),
                            //                 ),
                            //               ),
                            //               Flexible(
                            //                 flex: 1,
                            //                 child: Container(
                            //                   child: Center(
                            //                     child: Text("Issued Amount",
                            //                         textAlign: TextAlign.center,
                            //                         style: _textTheme.headlineSmall!
                            //                             .copyWith(fontSize: 12)),
                            //                   ),
                            //                 ),
                            //               ),
                            //               Flexible(
                            //                 flex: 1,
                            //                 child: Center(
                            //                   child: Text(
                            //                     "Principal",
                            //                     style: _textTheme.headlineSmall!
                            //                         .copyWith(fontSize: 12),
                            //                   ),
                            //                 ),
                            //               ),
                            //               Flexible(
                            //                 flex: 1,
                            //                 child: Center(
                            //                   child: Text(
                            //                     "Balance",
                            //                     style: _textTheme.headlineSmall!
                            //                         .copyWith(fontSize: 12),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         )
                            //       ]),
                            //     ),
                            //     ListView.builder(
                            //         shrinkWrap: true,
                            //         physics: const NeverScrollableScrollPhysics(),
                            //         itemCount: _response.length,
                            //         itemBuilder: (context, index) {
                            //           return LoanStatementRowWidget(
                            //             index: index,
                            //             responseData: response,
                            //           );
                            //         })
                          ],
                        )
                      : Container();
                } else if (state is CommonLoading) {
                  return const CommonLoadingWidget();
                } else if (state is CommonError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
