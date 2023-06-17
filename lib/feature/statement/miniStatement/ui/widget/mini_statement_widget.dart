import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/statement/miniStatement/cubit/mini_statement_cubit.dart';
import 'package:ismart/feature/statement/miniStatement/models/mini_statement_model.dart';

class MiniStatementWidget extends StatefulWidget {
  const MiniStatementWidget({Key? key}) : super(key: key);

  @override
  State<MiniStatementWidget> createState() => _MiniStatementWidgetState();
}

class _MiniStatementWidgetState extends State<MiniStatementWidget> {
  ValueNotifier<MiniStatementModel?> miniStatementDetail = ValueNotifier(null);
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final cubit = context.read<MiniStatementCubit>().fetchMiniStatement(
            accountNumbner:
                customerDetail.value!.accountDetail[0].accountNumber);
      },
    );
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      showAppBar: false,
      body: BlocConsumer<MiniStatementCubit, CommonState>(
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
          if (state is CommonStateSuccess<MiniStatementModel>) {
            return CommonContainer(
                showDetail: false,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<CustomerDetailModel?>(
                        valueListenable: customerDetail,
                        builder: (context, val, _) {
                          if (val != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Account Details ${val.accountDetail[0].mainCode}",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                SizedBox(height: _height * 0.01),
                                Container(
                                  padding: const EdgeInsets.all(18),
                                  width: double.infinity,
                                  height: _height * 0.11,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Available Balance",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          Text(
                                            "NPR ${val.accountDetail[0].availableBalance}",
                                            style: TextStyle(
                                                fontFamily: "popinBold",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Actual Balance",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                          Text(
                                            "NPR ${val.accountDetail[0].actualBalance}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "popinBold",
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: _height * 0.02),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                    DataTable(
                      headingRowHeight: 40,
                      dataTextStyle:
                          const TextStyle(fontSize: 12, color: Colors.black),
                      headingRowColor:
                          const MaterialStatePropertyAll(Colors.black12),
                      columns: const [
                        DataColumn(label: Text("DR/CR")),

                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Amount")),
                        DataColumn(label: Text("Status")),
                      ],
                      rows: state.data.ministatementList
                          .map((e) => DataRow(
                                cells: [
                                  DataCell(Text(
                                      "${e.transactionDate.year}-${e.transactionDate.month}-${e.transactionDate.year}")),
                                  DataCell(Text(
                                    e.amount.toString(),
                                    style: TextStyle(
                                        color: e.credit
                                            ? Colors.green
                                            : Colors.red),
                                  )),
                                  DataCell(Text(
                                    e.credit ? "Deposit" : "Withdrawl",
                                    style: TextStyle(
                                        color: e.credit
                                            ? Colors.green
                                            : Colors.red),
                                  )),
                                ],
                              ))
                          .toList(),

                      // DataRow(cells: [
                      //   DataCell(Text(state.data.ministatementList[0].remarks)),
                      //   DataCell(Text(state
                      //       .data.ministatementList[0].transactionDate
                      //       .toString())),
                      //   DataCell(Text(
                      //       state.data.ministatementList[0].amount.toString())),
                      // ])
                    ),
                  ],
                ),
                onButtonPressed: () {
                  NavigationService.push(target: const DashboardPage());
                },
                buttonName: "Close",
                title: "Mini Statement",
                detail: "",
                topbarName: "Statement");
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
