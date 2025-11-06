import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/file_download_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class LoanStatementWidget extends StatefulWidget {
  final String loanAccountNumber;

  const LoanStatementWidget({super.key, required this.loanAccountNumber});
  @override
  State<LoanStatementWidget> createState() => _LoanStatementWidgetState();
}

class _LoanStatementWidgetState extends State<LoanStatementWidget> {
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toDate = DateTime.now();
  final _width = SizeUtils.width;
  final _height = SizeUtils.height;
  bool sortList = false;
  // bool _pickerAD = true;

  @override
  void initState() {
    fetchLoanStatement(
      fromDate: fromDate,
      toDate: toDate,
    );
    super.initState();
  }

  int currentIndex = 0;

  fetchLoanStatement(
      {required DateTime fromDate, required DateTime toDate}) async {
    context.read<UtilityPaymentCubit>().fetchDetails(
        shouldIncludeMPIN: true,
        serviceIdentifier: "",
        accountDetails: {
          "accountNumber": widget.loanAccountNumber,
          "fromDate": DateFormat("yyyy-MM-dd").format(fromDate),
          "toDate": DateFormat("yyyy-MM-dd").format(toDate),
          "loanType": "loanType",
        },
        apiEndpoint: "api/loan/statement");
  }

  bool showInterestRate = false;

  List<Map<String, dynamic>> allData = [
    {"key": "tranDate", "title": "Tran Date"},
    {"key": "interestDate", "title": "Interest Date"},
    {"key": "description", "title": "Description"},
    {"key": "principle balance", "title": "Balance"},
    {"key": "payment", "title": "Payment"},
    {"key": "issuedAmount", "title": "Issued Amount"},
    {"key": "interest", "title": "Interest"},
    {"key": "rebate", "title": "Rebate"},
    {"key": "penalty", "title": "Penalty"},
    {"key": "principleBalance", "title": "Principle Balance"},
    {"key": "fine", "title": "Fine"},
    // {"key": "discount", "title": "Discount"},
    {"key": "principalDebit", "title": "Principal Debit"},
    {"key": "principalCredit", "title": "Principal Credit"},
    {"key": "lin", "title": "Lin"},
  ];

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 0,
        horizontalPadding: 0,
        topbarName: "Loan Statement",
        showRoundBotton: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                      predefinedPeriods.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 4.0, left: 4),
                        child: predefinedPeriodButton(
                          predefinedPeriods[index],
                          currentIndex == index,
                          predefinedTimeFrame[index],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: InkWell(
                      onTap: showFilterDialog,
                      child: Container(
                        width: _width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: currentIndex == -1
                                ? _theme.primaryColor
                                : Colors.black54,
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          children: [
                            Text(
                              "Filter",
                              style: _textTheme.labelLarge!.copyWith(
                                color: currentIndex == -1
                                    ? _theme.primaryColor
                                    : Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10.wp),
                            SvgPicture.asset(
                              Assets.filterIcon,
                              height: 25.hp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocConsumer<UtilityPaymentCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonStateSuccess<UtilityResponseData>) {
                  // final UtilityResponseData response = state.data;
                  // final _response = response.findValue(primaryKey: "data");
                  // showInterestRate = _response
                  //         .where((e) => e['interestDate'] == "N/A")
                  //         .length !=
                  //     _response.length;
                }
              },
              builder: (context, state) {
                if (state is CommonStateSuccess<UtilityResponseData>) {
                  final UtilityResponseData response = state.data;
                  final _response = response.findValue(primaryKey: "data");
                  if ((int.tryParse(_response?.length.toString() ?? "") ?? 0) <
                      1) {
                    return NoDataScreen(
                        title: "Loan Statement", details: response.message);
                  }
                  final firstItem = _response[0];
                  final availableValues = allData.where((e) =>
                      firstItem[e['key']] != 'N/A' &&
                      firstItem[e['key']] != null);

                  return response.details.isNotEmpty
                      ? Column(
                          children: [
                            if (response.detail.isNotEmpty)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        FileDownloadUtils.downloadFile(
                                          downloadLink: RepositoryProvider.of<
                                                      CoOperative>(context)
                                                  .baseUrl +
                                              response.detail,
                                          fileName: FileDownloadUtils
                                              .generateDownloadFileName(
                                            name: "Loan Statement",
                                            filetype: FileType.pdf,
                                          ),
                                          context: context,
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Download  ",
                                            style: _textTheme.labelLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          SvgPicture.asset(
                                            Assets.downloadIcon,
                                            height: 20.hp,
                                          ),
                                        ],
                                      )),
                                  const Spacer(),
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

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                headingRowColor: MaterialStatePropertyAll(
                                    _theme.primaryColor.withOpacity(0.05)),
                                columnSpacing: _width / 5,
                                columns: [
                                  const DataColumn(label: Text('SN')),
                                  for (var data in allData)
                                    if (firstItem[data['key']] != 'N/A' &&
                                        firstItem[data['key']] != null)
                                      DataColumn(label: Text(data['title']))

                                  // const DataColumn(
                                  //     label: Text(
                                  //   'Tranaction\nDate',
                                  //   textAlign: TextAlign.center,
                                  // )),
                                  // if (showInterestRate)
                                  //   const DataColumn(
                                  //       label: Text(
                                  //     'Interest\nDate',
                                  //     textAlign: TextAlign.center,
                                  //   )),
                                  // const DataColumn(
                                  //     label: Text(
                                  //   'Issued\nAmount',
                                  //   textAlign: TextAlign.center,
                                  // )),
                                  // const DataColumn(label: Text('Payment')),
                                  // const DataColumn(label: Text('Principal')),
                                  // const DataColumn(label: Text('Interest')),
                                  // const DataColumn(label: Text('Fine')),
                                  // const DataColumn(label: Text('Discount')),
                                  // const DataColumn(label: Text('Balance')),
                                  // const DataColumn(
                                  //     label: Text('Statement Reference')),
                                ],
                                rows: List.generate(
                                  _response.length,
                                  (index) => DataRow(
                                      color: MaterialStatePropertyAll(
                                          index.isEven
                                              ? CustomTheme.white
                                              : _theme.primaryColor
                                                  .withOpacity(0.03)),
                                      cells: [
                                        DataCell(Text("${index + 1}")),
                                        for (var data in allData)
                                          if (firstItem[data['key']] != 'N/A' &&
                                              firstItem[data['key']] != null)
                                            DataCell(Text(_response[index]
                                                    [data['key']]
                                                .toString())),
                                        // DataCell(Text(_response[index]
                                        //         ['tranDate'] ??
                                        //     '')),
                                        // DataCell(Text(_response[index]
                                        //         ['interestDate']
                                        //     .toString())),
                                        // DataCell(Text(_response[index]
                                        //         ['issuedAmount']
                                        //     .toString())),
                                        // DataCell(Text(_response[index]
                                        //         ['payment']
                                        //     .toString())),
                                        // DataCell(Text(_response[index]
                                        //         ['principal']
                                        //     .toString())),
                                        // DataCell(Text(_response[index]
                                        //         ['interest']
                                        //     .toString())),
                                        // DataCell(Text(_response[index]['fine']
                                        //     .toString())),
                                        // DataCell(Text(_response[index]
                                        //         ['discount']
                                        //     .toString())),
                                        // DataCell(Text(_response[index]
                                        //         ['balance']
                                        //     .toString())),
                                        // DataCell(SizedBox(
                                        //   width: 30.w,
                                        //   child: Text(_response[index]
                                        //           ['statementReference']
                                        //       .toString()),
                                        // )),
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
                      : NoDataScreen(
                          title: "No Statement Found",
                          details: response.message);
                } else if (state is CommonLoading) {
                  return const CommonLoadingWidget();
                } else if (state is CommonError) {
                  return NoDataScreen(
                      title: "No Statement Found", details: state.message);
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

  final List<int> predefinedPeriods = [30, 90, 365];
  final List<String> predefinedTimeFrame = ['1 Month', '3 Month', '1 Year'];
  Widget predefinedPeriodButton(int days, bool isSelected, String frame) {
    return CustomRoundedButtom(
      color: CustomTheme.primaryColor.withOpacity(isSelected ? 1 : 0.5),
      title: "$frame",
      onPressed: () => selectPredefinedPeriod(days),
      fontSize: 11,
    );
  }

  void selectPredefinedPeriod(int days) {
    setState(() {
      toDate = DateTime.now();
      fromDate = toDate.subtract(Duration(days: days));
      currentIndex = predefinedPeriods.indexOf(days);
    });
    fetchLoanStatement(fromDate: fromDate, toDate: toDate);
  }

  DateTime filtertoDate = DateTime.now();
  DateTime filterfromDate = DateTime.now().subtract(const Duration(days: 90));
  Future<void> showFilterDialog() async {
    DateTime tempFromDate = filterfromDate;
    DateTime tempToDate = filtertoDate;
    bool _pickerAD = false;
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Date",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  dialogSetState(() {
                                    _pickerAD = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: _pickerAD
                                        ? CustomTheme.primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "AD",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: _pickerAD
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  dialogSetState(() {
                                    _pickerAD = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: !_pickerAD
                                        ? CustomTheme.primaryColor
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    "BS",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: !_pickerAD
                                          ? Colors.white
                                          : Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked;

                        if (_pickerAD) {
                          picked = await showDatePicker(
                            context: context,
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: CustomTheme.primaryColor,
                                  onPrimary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomTheme.primaryColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            ),
                            initialDate: tempFromDate,
                            firstDate: DateTime(2021),
                            lastDate: DateTime.now(),
                          );
                        } else {
                          final NepaliDateTime? pickedDate =
                              await showNepaliDatePicker(
                            context: context,
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: CustomTheme.primaryColor,
                                  onPrimary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomTheme.primaryColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            ),
                            initialDate: NepaliDateTime.now(),
                            firstDate: NepaliDateTime(2070),
                            lastDate: NepaliDateTime(2090),
                            initialDatePickerMode: DatePickerMode.day,
                          );
                          picked = pickedDate?.toDateTime();
                        }

                        if (picked != null) {
                          dialogSetState(() {
                            tempFromDate = picked!;
                            if (tempToDate.difference(tempFromDate).inDays >
                                90) {
                              tempToDate = DateTime.now();
                            }
                          });
                        }
                      },
                      title: "From Date",
                      hintText:
                          "${tempFromDate.year}-${tempFromDate.month.toString().padLeft(2, '0')}-${tempFromDate.day.toString().padLeft(2, '0')}",
                      showSuffixImage: true,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked;

                        if (_pickerAD) {
                          picked = await showDatePicker(
                            context: context,
                            initialDate: tempToDate,
                            firstDate: tempFromDate,
                            lastDate: DateTime.now(),
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: CustomTheme.primaryColor,
                                  onPrimary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomTheme.primaryColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            ),
                          );
                        } else {
                          final NepaliDateTime? pickedDate =
                              await showNepaliDatePicker(
                            builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: CustomTheme.primaryColor,
                                  onPrimary: Colors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: CustomTheme.primaryColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            ),
                            context: context,
                            initialDate: tempToDate.toNepaliDateTime(),
                            firstDate: tempFromDate.toNepaliDateTime(),
                            lastDate: NepaliDateTime.now(),
                            initialDatePickerMode: DatePickerMode.day,
                          );
                          picked = pickedDate?.toDateTime();
                        }

                        if (picked != null) {
                          dialogSetState(() {
                            tempToDate = picked!;
                          });
                        }
                      },
                      title: "To Date",
                      hintText:
                          "${tempToDate.year}-${tempToDate.month.toString().padLeft(2, '0')}-${tempToDate.day.toString().padLeft(2, '0')}",
                      showSuffixImage: true,
                    ),
                    const SizedBox(height: 24),
                    CustomRoundedButtom(
                      title: "View",
                      onPressed: () {
                        setState(() {
                          filterfromDate = tempFromDate;
                          filtertoDate = tempToDate;
                          fromDate = filterfromDate;
                          toDate = filtertoDate;
                          currentIndex = -1;
                        });
                        fetchLoanStatement(fromDate: fromDate, toDate: toDate);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  // Future<void> showFilterDialog() async {
  //   DateTime tempFromDate = filterfromDate;
  //   DateTime tempToDate = filtertoDate;

  //   await showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           bool _pickerAD = true;
  //           return Dialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(18),
  //             ),
  //             elevation: 0,
  //             backgroundColor: Colors.transparent,
  //             child: Container(
  //               padding: const EdgeInsets.all(18),
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 shape: BoxShape.rectangle,
  //                 borderRadius: BorderRadius.circular(18),
  //                 boxShadow: const [
  //                   BoxShadow(
  //                     color: Colors.black26,
  //                     blurRadius: 10.0,
  //                     offset: Offset(0.0, 10.0),
  //                   ),
  //                 ],
  //               ),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         "Select Date",
  //                         style:
  //                             Theme.of(context).textTheme.titleLarge!.copyWith(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 16,
  //                                 ),
  //                       ),
  //                       Row(
  //                         children: [
  //                           InkWell(
  //                             onTap: () {
  //                               setState(() {
  //                                 _pickerAD = true;
  //                                 print("This is picked $_pickerAD");
  //                               });
  //                             },
  //                             child: Text(
  //                               "AD",
  //                               style: TextStyle(
  //                                   fontSize: 12,
  //                                   color: _pickerAD
  //                                       ? CustomTheme.primaryColor
  //                                       : Colors.black),
  //                             ),
  //                           ),
  //                           const SizedBox(
  //                             width: 10,
  //                           ),
  //                           InkWell(
  //                             onTap: () {
  //                               setState(() {
  //                                 _pickerAD = false;
  //                                 print("This is picked $_pickerAD");
  //                               });
  //                             },
  //                             child: Text(
  //                               "BS",
  //                               style: TextStyle(
  //                                   fontSize: 12,
  //                                   color: _pickerAD
  //                                       ? Colors.black
  //                                       : CustomTheme.primaryColor),
  //                             ),
  //                           )
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                   const SizedBox(height: 16),
  //                   CustomTextField(
  //                     readOnly: true,
  //                     onTap: () async {
  //                       // final DateTime? picked = await showDatePicker(
  //                       //   context: context,
  //                       //   initialDate: tempFromDate,
  //                       //   firstDate: DateTime(2021),
  //                       //   lastDate: DateTime.now(),
  //                       // );
  //                       final NepaliDateTime? pickedDate =
  //                           await showMaterialDatePicker(
  //                         context: context,
  //                         initialDate: NepaliDateTime.now(),
  //                         firstDate: NepaliDateTime(2070),
  //                         lastDate: NepaliDateTime(2090),
  //                         initialDatePickerMode: DatePickerMode.day,
  //                       );
  //                       print('Picked date : ${pickedDate?.toDateTime()}');
  //                       final picked = pickedDate?.toDateTime();
  //                       if (picked != null) {
  //                         setState(() {
  //                           tempFromDate = picked;
  //                           if (tempToDate.difference(tempFromDate).inDays >
  //                               90) {
  //                             tempToDate = DateTime.now();
  //                           }
  //                         });
  //                       }
  //                     },
  //                     title: "From Date",
  //                     hintText:
  //                         "${tempFromDate.year}-${tempFromDate.month}-${tempFromDate.day}",
  //                     showSuffixImage: true,
  //                   ),
  //                   const SizedBox(height: 16),
  //                   CustomTextField(
  //                     readOnly: true,
  //                     onTap: () async {
  //                       final DateTime? picked = await showDatePicker(
  //                         context: context,
  //                         initialDate: tempToDate,
  //                         firstDate: tempFromDate,
  //                         lastDate: DateTime.now(),
  //                       );
  //                       if (picked != null) {
  //                         setState(() {
  //                           tempToDate = picked;
  //                         });
  //                       }
  //                     },
  //                     title: "To Date",
  //                     hintText:
  //                         "${tempToDate.year}-${tempToDate.month}-${tempToDate.day}",
  //                     showSuffixImage: true,
  //                   ),
  //                   const SizedBox(height: 24),
  //                   CustomRoundedButtom(
  //                     title: "View",
  //                     onPressed: () {
  //                       setState(() {
  //                         filterfromDate = tempFromDate;
  //                         filtertoDate = tempToDate;
  //                         fromDate = filterfromDate;
  //                         toDate = filtertoDate;
  //                         currentIndex = -1; // Custom range selected
  //                       });
  //                       fetchLoanStatement(fromDate: fromDate, toDate: toDate);
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
