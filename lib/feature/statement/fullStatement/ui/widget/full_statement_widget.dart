import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/file_download_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/primary_account_box.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/statement_detail_box.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/statement/fullStatement/cubit/full_statement_cubit.dart';
import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
import 'package:path_provider/path_provider.dart';

class FullStatementWidget extends StatefulWidget {
  @override
  State<FullStatementWidget> createState() => _FullStatementWidgetState();
}

class _FullStatementWidgetState extends State<FullStatementWidget> {
  Dio dio = Dio();
  String url = "https://www.africau.edu/images/default/sample.pdf";
  int startDay = 15;
  List numberOfDaysText = ["15 Days", "1 Month", "3 Month"];
  List numberOfDays = [15, 30, 90];

  DateTime fromDate = DateTime.now();
  DateTime fromDateAlert = DateTime.now();
  DateTime toDateAlert = DateTime.now();

  DateTime toDate = DateTime.now();
  ValueNotifier<FullStatementModel?> fullStatementDetail = ValueNotifier(null);
  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);
  void getData({required DateTime fromdate, required todate}) {
    context.read<FullStatementCubit>().fetchFullStatement(
        accountNumber: RepositoryProvider.of<CustomerDetailRepository>(context)
                .selectedAccount
                .value
                ?.accountNumber ??
            "",
        fromDate: fromdate,
        toDate: todate);
  }

  @override
  void initState() {
    super.initState();
    getData(
      fromdate: fromDate.subtract(Duration(days: startDay)),
      todate: toDate,
    );
  }

  int selectedDays = 0;
  bool _isLoading = false;
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showRoundBotton: false,
        showDetail: true,
        topbarName: "Statement",
        showTitleText: false,
        buttonName: "Close",
        title: "Full Statement",
        detail: "Full Statement ",
        body: Column(
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
                              fromDate = DateTime.now().subtract(
                                  Duration(days: numberOfDays[index]));
                              // fromDateAlert = DateTime.now();
                              selectedDays = index;
                              // startDay = numberOfDays[index];
                            });
                            getData(fromdate: fromDate, todate: toDate);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: _width * 0.2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: fromDateAlert != DateTime.now()
                                        ? selectedDays == index
                                            ? _theme.primaryColor
                                            : Colors.black54
                                        : Colors.black54)),
                            child: Center(
                                child: Text(
                              "${numberOfDaysText[index]}",
                              style: _textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: fromDateAlert != DateTime.now()
                                      ? selectedDays == index
                                          ? _theme.primaryColor
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
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            actionsPadding: EdgeInsets.zero,
                            actions: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Filter",
                                          style: _textTheme.labelLarge!
                                              .copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        PrimaryAccountBox(),
                                        CustomTextField(
                                          customHintTextStyle: true,
                                          readOnly: true,
                                          onTap: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: fromDate,
                                                    firstDate:
                                                        DateTime(2015, 8),
                                                    lastDate: DateTime.now());
                                            setState(() {
                                              fromDateAlert = picked!;
                                            });
                                          },
                                          showSuffixImage: true,
                                          title: "From Date",
                                          hintText:
                                              "${fromDateAlert.year}-${fromDateAlert.month}-${fromDateAlert.day}",
                                        ),
                                        CustomTextField(
                                          showSuffixImage: true,
                                          customHintTextStyle: true,
                                          readOnly: true,
                                          hintText:
                                              "${toDate.year}-${toDate.month}-${toDate.day}",
                                          title: "To Date",
                                          onTap: () async {
                                            final DateTime? picked =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate:
                                                        DateTime(2015, 8),
                                                    lastDate: DateTime.now());
                                            setState(() {
                                              toDateAlert = picked!;
                                            });
                                          },
                                        ),
                                        CustomRoundedButtom(
                                            title: "View",
                                            onPressed: () {
                                              getData(
                                                  fromdate: fromDateAlert,
                                                  todate: toDateAlert);
                                              NavigationService.pop();
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
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: fromDateAlert != DateTime.now()
                                ? Colors.black54
                                : _theme.primaryColor)),
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Text(
                          "Filter",
                          style: _textTheme.labelLarge!.copyWith(
                              color: fromDateAlert != DateTime.now()
                                  ? Colors.black54
                                  : _theme.primaryColor,
                              fontWeight: FontWeight.bold),
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
            BlocConsumer<FullStatementCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoading && !_isLoading) {
                  _isLoading = true;
                  showLoadingDialogBox(context);
                }
                if (state is! CommonLoading && _isLoading) {
                  _isLoading = false;
                  NavigationService.pop();
                }

                // if (state is CommonError) {
                //   showPopUpDialog(
                //     context: context,
                //     message: state.message,
                //     title: "Error",
                //     showCancelButton: false,
                //     buttonCallback: () {
                //       NavigationService.pop();
                //     },
                //   );
                // }
              },
              builder: (context, state) {
                if (state is CommonStateSuccess<FullStatementModel>) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: _height * 0.01),
                      InkWell(
                          onTap: () {
                            FileDownloadUtils.downloadFile(
                              downloadLink:
                                  RepositoryProvider.of<CoOperative>(context)
                                          .baseUrl +
                                      state.data.pdfUrl.toString(),
                              fileName:
                                  FileDownloadUtils.generateDownloadFileName(
                                name: "Statement",
                                filetype: FileType.pdf,
                              ),
                              context: context,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Download  ",
                                style: _textTheme.labelLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              SvgPicture.asset(
                                Assets.downloadIcon,
                                height: 20.hp,
                              ),
                            ],
                          )),
                      SizedBox(height: _height * 0.01),
                      state.data.accountStatementDtos.isEmpty
                          ? const NoDataScreen(
                              title: "No transactions yet",
                              details: "Make Your First Transfer",
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: _height * 0.01),
                                // Row(children: [
                                //   Text(
                                //     "Statement",
                                //     style: _textTheme.titleLarge!
                                //         .copyWith(
                                //             fontWeight: FontWeight.w600),
                                //   ),
                                //   const Spacer(),
                                //   InkWell(
                                //     onTap: () {},
                                //     child: SvgPicture.asset(
                                //       Assets.downloadIcon,
                                //       height: _height * 0.03,
                                //     ),
                                //   )
                                // ]),
                                SizedBox(height: _height * 0.01),
                                Container(
                                  width: double.infinity,
                                  height: 500,
                                  child: ListView.builder(
                                    itemCount:
                                        state.data.accountStatementDtos.length,
                                    itemBuilder: (context, index) {
                                      final data = state
                                          .data.accountStatementDtos[index];
                                      return StatementDetailBox(
                                          balance: data.balance.toString(),
                                          isCredit:
                                              data.credit != 0 ? true : false,
                                          desc: data.remarks.toString(),
                                          amount: data.credit == 0
                                              ? data.debit.toString()
                                              : data.credit.toString(),
                                          dateTime:
                                              data.transactionDate.toString(),
                                          imageUrl: "",
                                          status: data.credit != 0
                                              ? "Deposit"
                                              : "Withdrawl");
                                    },
                                  ),
                                ),
                                CustomRoundedButtom(
                                    title: "Close",
                                    onPressed: () {
                                      NavigationService.push(
                                          target: const DashboardPage());
                                    })
                              ],
                            ),
                    ],
                  );
                } else {
                  return NoDataScreen(
                    title: "No transactions yet",
                    details: "Make Your First Transfer",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }
  // Future<void> downloadPDF(
  //     {required String path, required String fileName}) async {
  //   final url = RepositoryProvider.of<CoOperative>(context)
  //       .baseUrl; // Replace with your PDF URL

  //   final response = await http.get(Uri.parse(url));
  //   final bytes = response.bodyBytes;

  //   final directory = await getExternalStorageDirectory();
  //   final path = '${directory!.path}/$fileName'; // File path on the device

  //   await FlutterDownloader.enqueue(
  //     url: url,
  //     savedDir: directory.filePath,
  //     fileName: 'sample.pdf',
  //     showNotification: true,
  //     openFileFromNotification: true,
  //     headers: {'content-length': response.headers['content-length'] ?? ""},
  //   );
  // }
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
                           