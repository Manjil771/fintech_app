import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/primary_account_box.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/statement_detail_box.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/statement/fullStatement/cubit/mini_statement_cubit.dart';
import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
import 'package:ismart/feature/statement/miniStatement/cubit/mini_statement_cubit.dart';
import 'package:ismart/feature/statement/miniStatement/models/mini_statement_model.dart';

class FullStatementWidget extends StatefulWidget {
  @override
  State<FullStatementWidget> createState() => _FullStatementWidgetState();
}

class _FullStatementWidgetState extends State<FullStatementWidget> {
  int startDay = 15;
  List numberOfDaysText = ["15 Days", "1 Month", "3 Month"];
  List numberOfDays = [15, 30, 90];

  DateTime fromDate = DateTime.now();
  DateTime fromDateAlert = DateTime.now();

  DateTime toDate = DateTime.now();
  ValueNotifier<FullStatementModel?> fullStatementDetail = ValueNotifier(null);
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);
  void getData() {
    DateTime fromDate = fromDateAlert == DateTime.now()
        ? DateTime.now().subtract(Duration(days: startDay))
        : fromDateAlert;
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final cubit = context.read<FullStatementCubit>().fetchFullStatement(
            accountNumber: customerDetail.value!.accountDetail[0].accountNumber,
            fromDate: fromDate,
            toDate: toDate);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  int selectedDays = 0;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: _height * 0.04,
                                      child: ListView.builder(
                                        itemCount: numberOfDays.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                fromDateAlert = DateTime.now();
                                                selectedDays = index;
                                                startDay = numberOfDays[index];
                                              });
                                              getData();
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              width: _width * 0.2,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: fromDateAlert !=
                                                              DateTime.now()
                                                          ? selectedDays ==
                                                                  index
                                                              ? _theme
                                                                  .primaryColor
                                                              : Colors.black54
                                                          : Colors.black54)),
                                              child: Center(
                                                  child: Text(
                                                "${numberOfDaysText[index]}",
                                                style: _textTheme.labelLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: fromDateAlert !=
                                                                DateTime.now()
                                                            ? selectedDays ==
                                                                    index
                                                                ? _theme
                                                                    .primaryColor
                                                                : Colors.black54
                                                            : Colors.black54),
                                              )),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return AlertDialog(
                                              actionsPadding: EdgeInsets.zero,
                                              actions: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            18.0),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Filter",
                                                            style: _textTheme
                                                                .labelLarge!
                                                                .copyWith(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          PrimaryAccountBox(),
                                                          CustomTextField(
                                                            customHintTextStyle:
                                                                true,
                                                            readOnly: true,
                                                            onTap: () async {
                                                              final DateTime?
                                                                  picked =
                                                                  await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          fromDate,
                                                                      firstDate:
                                                                          DateTime(
                                                                              2015,
                                                                              8),
                                                                      lastDate:
                                                                          DateTime
                                                                              .now());
                                                              setState(() {
                                                                fromDateAlert =
                                                                    picked!;
                                                              });
                                                            },
                                                            showSuffixImage:
                                                                true,
                                                            title: "From Date",
                                                            hintText:
                                                                "${fromDateAlert.year}-${fromDateAlert.month}-${fromDateAlert.day}",
                                                          ),
                                                          CustomTextField(
                                                            showSuffixImage:
                                                                true,
                                                            customHintTextStyle:
                                                                true,
                                                            readOnly: true,
                                                            hintText:
                                                                "${toDate.year}-${toDate.month}-${toDate.day}",
                                                            title: "To Date",
                                                            onTap: () async {
                                                              final DateTime? picked = await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2015,
                                                                          8),
                                                                  lastDate:
                                                                      DateTime
                                                                          .now());
                                                              setState(() {
                                                                toDate =
                                                                    picked!;
                                                              });
                                                            },
                                                          ),
                                                          CustomRoundedButtom(
                                                              title: "View",
                                                              onPressed: () {
                                                                print(fromDate);
                                                                print(toDate);
                                                                getData();
                                                                NavigationService
                                                                    .pop();
                                                              })
                                                        ]),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: _height * 0.04,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: fromDateAlert !=
                                                      DateTime.now()
                                                  ? Colors.black54
                                                  : _theme.primaryColor)),
                                      margin: EdgeInsets.only(left: 5),
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Filter",
                                            style: _textTheme.labelLarge!
                                                .copyWith(
                                                    color: fromDateAlert !=
                                                            DateTime.now()
                                                        ? Colors.black54
                                                        : _theme.primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          SizedBox(width: _width * 0.02),
                                          SvgPicture.asset(
                                            Assets.filterIcon,
                                            height: _height * 0.025,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: _height * 0.01),
                              state.data.accountStatementDtos!.isEmpty
                                  ? NoDataScreen(
                                      title: "No transactions yet",
                                      details: "Make Your First Transfer",
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(18),
                                          width: double.infinity,
                                          height: _height * 0.11,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor),
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
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: _height * 0.02),
                                        Container(
                                          width: double.infinity,
                                          height: 500,
                                          child: ListView.builder(
                                            itemCount: state.data
                                                .accountStatementDtos!.length,
                                            itemBuilder: (context, index) {
                                              var data = state.data
                                                  .accountStatementDtos![index];
                                              return StatementDetailBox(
                                                  balance:
                                                      data.balance.toString(),
                                                  isCredit: data.credit == 0
                                                      ? true
                                                      : false,
                                                  desc: data.remarks.toString(),
                                                  amount: data.credit == 0
                                                      ? data.debit.toString()
                                                      : data.credit.toString(),
                                                  dateTime: data.transactionDate
                                                      .toString(),
                                                  imageUrl: "",
                                                  status: data.credit == 0
                                                      ? "Withdrawl"
                                                      : "Deposit");
                                            },
                                          ),
                                        ),
                                      ],
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
                showTitleText: false,
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



//  SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: DataTable(
//                                   headingRowHeight: 40,
//                                   dataTextStyle: TextStyle(
//                                       fontSize: 12, color: Colors.black),
//                                   headingRowColor:
//                                       MaterialStatePropertyAll(Colors.black12),
//                                   columnSpacing: _width * 0.05,
//                                   columns: [
//                                     // DataColumn(label: Text("SN")),
//                                     DataColumn(label: Text("Date")),
//                                     DataColumn(label: Text("Withdrawl")),
//                                     DataColumn(label: Text("Deposit")),
//                                     DataColumn(label: Text("Balance")),
//                                   ],
//                                   rows: state.data.accountStatementDtos!
//                                       .map((e) => DataRow(
//                                             cells: [
//                                               DataCell(
//                                                 Center(
//                                                   child: Text(e.transactionDate
//                                                       .toString()),
//                                                 ),
//                                               ),
//                                               DataCell(Center(
//                                                 child: Text(
//                                                   e.debit.toString(),
//                                                   style: TextStyle(
//                                                       color: CustomTheme.green),
//                                                 ),
//                                               )),
//                                               DataCell(Center(
//                                                 child: Text(e.credit.toString(),
//                                                     style: TextStyle(
//                                                         color: Colors.red)),
//                                               )),
//                                               DataCell(Center(
//                                                   child: Text(
//                                                       e.balance.toString()))),
//                                             ],
//                                           ))
//                                       .toList(),
//                                 ),
//                               ),
                           