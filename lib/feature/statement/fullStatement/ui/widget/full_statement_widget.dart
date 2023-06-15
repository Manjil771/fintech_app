import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/primary_account_box.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/statement/fullStatement/cubit/mini_statement_cubit.dart';
import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
import 'package:ismart/feature/statement/miniStatement/cubit/mini_statement_cubit.dart';
import 'package:ismart/feature/statement/miniStatement/models/mini_statement_model.dart';

class FullStatementWidget extends StatefulWidget {
  final DateTime fromDate;
  final DateTime toDate;

  const FullStatementWidget(
      {Key? key, required this.fromDate, required this.toDate})
      : super(key: key);

  @override
  State<FullStatementWidget> createState() => _FullStatementWidgetState();
}

class _FullStatementWidgetState extends State<FullStatementWidget> {
  ValueNotifier<FullStatementModel?> fullStatementDetail = ValueNotifier(null);
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final cubit = context.read<FullStatementCubit>().fetchFullStatement(
            accountNumber: customerDetail.value!.accountDetail[0].accountNumber,
            fromDate: widget.fromDate,
            toDate: widget.toDate);
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
      body: BlocConsumer<FullStatementCubit, CommonState>(
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
          if (state is CommonStateSuccess<FullStatementModel>) {
            return CommonContainer(
                showDetail: false,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocConsumer<FullStatementCubit, CommonState>(
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
                        if (state is CommonStateSuccess<FullStatementModel>) {
                          return Column(
                            children: [
                              PrimaryAccountBox(),
                              // Text(
                              //     "Account Details ${state.data.accountNumber}",
                              //     style:
                              //         Theme.of(context).textTheme.titleLarge),
                              SizedBox(height: _height * 0.01),
                              Container(
                                padding: const EdgeInsets.all(18),
                                width: double.infinity,
                                height: _height * 0.11,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
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
                                          "Opening Balance",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Text(
                                          "NPR ${state.data.openingBalance}",
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
                                          "Closing Balance",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        Text(
                                          "NPR ${state.data.closingBalance}",
                                          style: TextStyle(
                                              fontFamily: "popinBold",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: _height * 0.02),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  headingRowHeight: 40,
                                  dataTextStyle: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                  headingRowColor:
                                      MaterialStatePropertyAll(Colors.black12),
                                  columnSpacing: _width * 0.1,
                                  columns: [
                                    // DataColumn(label: Text("SN")),
                                    DataColumn(label: Text("Date")),
                                    DataColumn(label: Text("Debit")),
                                    DataColumn(label: Text("Credit")),
                                    DataColumn(label: Text("Balance")),
                                  ],
                                  rows: state.data.accountStatementDtos!
                                      .map((e) => DataRow(
                                            cells: [
                                              DataCell(
                                                Text(e.transactionDate
                                                    .toString()),
                                              ),
                                              DataCell(Text(
                                                e.debit.toString(),
                                                style: TextStyle(
                                                    color: CustomTheme.green),
                                              )),
                                              DataCell(Text(e.credit.toString(),
                                                  style: TextStyle(
                                                      color: Colors.red))),
                                              DataCell(
                                                  Text(e.balance.toString())),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container(
                            child: Text(state.toString()),
                          );
                        }
                      },
                    ),
                  ],
                ),
                onButtonPressed: () {
                  NavigationService.push(target: DashboardPage());
                },
                buttonName: "Close",
                title: "Full Statement",
                detail: "Full Statement ",
                topbarName: "Statement");
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
