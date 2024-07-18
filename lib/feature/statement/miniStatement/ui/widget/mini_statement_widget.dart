import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
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
                RepositoryProvider.of<CustomerDetailRepository>(context)
                    .selectedAccount
                    .value!
                    .accountNumber);
      },
    );
  }

  bool sortList = false;
  getList({required List dataList}) {
    return sortList == true ? dataList.reversed.toList() : dataList;
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final selectedAccount =
        RepositoryProvider.of<CustomerDetailRepository>(context)
            .selectedAccount
            .value;
    final _theme = Theme.of(context);
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
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
            final res = state.data.ministatementList;

            return CommonContainer(
              horizontalPadding: 0,
              showDetail: false,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       shotList = !shotList;
                  //     });
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //     child: SvgPicture.asset(Assets.sortICon, height: 20),
                  //   ),
                  // ),
                  ValueListenableBuilder<CustomerDetailModel?>(
                      valueListenable: customerDetail,
                      builder: (context, val, _) {
                        if (val != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 18),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              "Account No. ${selectedAccount!.mainCode}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge),
                                        ),
                                        SizedBox(width: 15.wp),
                                        Text(
                                          "Sorting",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              letterSpacing: 0.3,
                                              color: CustomTheme.primaryColor),
                                        ),
                                        Switch(
                                          activeColor: CustomTheme.primaryColor,
                                          value: sortList,
                                          onChanged: (value) {
                                            setState(() {
                                              sortList = !sortList;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
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
                                            color:
                                                Theme.of(context).primaryColor),
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
                                                "NPR ${selectedAccount.availableBalance}",
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
                                                "NPR ${selectedAccount.actualBalance}",
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
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                  if (state.data.ministatementList.isNotEmpty)
                    DataTable(
                      sortAscending: false,

                      columnSpacing: _width / 5,
                      headingRowHeight: 40,
                      dataTextStyle:
                          const TextStyle(fontSize: 12, color: Colors.black),
                      headingRowColor:
                          const MaterialStatePropertyAll(Colors.black12),
                      columns: const [
                        DataColumn(
                            label: Text(
                          "Date",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        )),
                        DataColumn(
                            label: Text("Amount",
                                style: TextStyle(fontWeight: FontWeight.w700))),
                        DataColumn(
                            label: Text("Status",
                                style: TextStyle(fontWeight: FontWeight.w700))),
                      ],
                      rows: List.from(getList(dataList: res))
                          .map((e) => DataRow(
                                cells: [
                                  DataCell(Text(e.transactionDate.toString())),
                                  // DataCell(Text(
                                  //     "${e.transactionDate.year}-${e.transactionDate.month}-${e.transactionDate.day}")),
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
                  if (state.data.ministatementList.isEmpty)
                    Container(
                      child: const Center(
                        child: Text(
                          "No data found.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onButtonPressed: () {
                NavigationService.pushReplacement(
                    target: const DashboardPage());
              },
              verticalPadding: 0,
              buttonName: "Close",
              topbarName: "  Mini Statement",
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
