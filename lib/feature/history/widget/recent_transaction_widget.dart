import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/feature/history/cubit/receipt_download_cubit.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/widget/transaction_detail_widget.dart';

class RecentTransactionWidget extends StatefulWidget {
  const RecentTransactionWidget({Key? key}) : super(key: key);

  @override
  State<RecentTransactionWidget> createState() =>
      _RecentTransactionWidgetState();
}

class _RecentTransactionWidgetState extends State<RecentTransactionWidget> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().subtract(const Duration(days: 15));

  @override
  void initState() {
    super.initState();
    getRecentTransaction(fromDate, toDate);
  }

  getRecentTransaction(DateTime fromDatee, DateTime toDatee) {
    context.read<RecentTransactionCubit>().fetchrecentTransaction(
        fromDate:
            DateFormat("yyyy-mm-dd").parse(fromDatee.toString()).toString(),
        toDate: DateFormat("yyyy-mm-dd").parse(toDatee.toString()).toString(),
        serviceCategoryId: "",
        associatedId: "",
        serviceId: "");
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      padding: EdgeInsets.zero,
      showAppBar: false,
      body: CommonContainer(
        showDetail: false,
        showBackBotton: false,
        showRoundBotton: false,
        showTitleText: false,
        topbarName: "Recent Transaction",
        body: BlocConsumer<RecentTransactionCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoading && !_isLoading) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            }
          },
          builder: (context, state) {
            print("state iss $state");
            final ValueNotifier<String> _downloadNotifierValue =
                ValueNotifier("");
            if (state is CommonDataFetchSuccess<RecentTransactionModel>) {
              return BlocListener<TransactionDownloadCubit, CommonState>(
                listener: (context, state) {
                  if (state is CommonStateSuccess) {
                    _downloadNotifierValue.value = state.data;
                  }
                },
                child: Column(
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return StatefulBuilder(
                    //             builder: (context, setState) {
                    //           return AlertDialog(
                    //             actionsPadding: EdgeInsets.zero,
                    //             actions: [
                    //               Container(
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.white,
                    //                   borderRadius: BorderRadius.circular(18),
                    //                 ),
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(18.0),
                    //                   child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           "Filter",
                    //                           style: _textTheme.labelLarge!
                    //                               .copyWith(
                    //                                   fontSize: 18,
                    //                                   fontWeight:
                    //                                       FontWeight.bold),
                    //                         ),
                    //                         PrimaryAccountBox(),
                    //                         CustomTextField(
                    //                           customHintTextStyle: true,
                    //                           readOnly: true,
                    //                           onTap: () async {
                    //                             final DateTime? picked =
                    //                                 await showDatePicker(
                    //                                     context: context,
                    //                                     initialDate: fromDate,
                    //                                     firstDate:
                    //                                         DateTime(2000, 8),
                    //                                     lastDate:
                    //                                         DateTime.now());
                    //                             setState(() {
                    //                               fromDate = picked!;
                    //                             });
                    //                           },
                    //                           showSuffixImage: true,
                    //                           title: "From Date",
                    //                           hintText:
                    //                               "${fromDate.year}-${fromDate.month}-${fromDate.day}",
                    //                         ),
                    //                         CustomTextField(
                    //                           showSuffixImage: true,
                    //                           customHintTextStyle: true,
                    //                           readOnly: true,
                    //                           hintText:
                    //                               "${toDate.year}-${toDate.month}-${toDate.day}",
                    //                           title: "To Date",
                    //                           onTap: () async {
                    //                             final DateTime? picked =
                    //                                 await showDatePicker(
                    //                                     context: context,
                    //                                     initialDate: toDate,
                    //                                     firstDate:
                    //                                         DateTime(2020, 8),
                    //                                     lastDate:
                    //                                         DateTime.now());
                    //                             setState(() {
                    //                               toDate = picked!;
                    //                             });
                    //                           },
                    //                         ),
                    //                         CustomRoundedButtom(
                    //                             title: "View",
                    //                             onPressed: () {
                    //                               getRecentTransaction(
                    //                                   fromDate, toDate);
                    //                               NavigationService.pop();
                    //                             })
                    //                       ]),
                    //                 ),
                    //               ),
                    //             ],
                    //           );
                    //         });
                    //       },
                    //     );
                    //   },
                    //   child: Container(
                    //     height: _height * 0.04,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(6),
                    //         border: Border.all(
                    //             color: fromDate != DateTime.now()
                    //                 ? Colors.black54
                    //                 : _theme.primaryColor)),
                    //     margin: const EdgeInsets.only(left: 5),
                    //     padding: const EdgeInsets.all(4),
                    //     child: Row(
                    //       children: [
                    //         Text(
                    //           "Filter",
                    //           style: _textTheme.labelLarge!.copyWith(
                    //               color: fromDate != DateTime.now()
                    //                   ? Colors.black54
                    //                   : _theme.primaryColor,
                    //               fontWeight: FontWeight.bold),
                    //         ),
                    //         SizedBox(width: _width * 0.02),
                    //         SvgPicture.asset(
                    //           Assets.filterIcon,
                    //           height: _height * 0.025,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        final _detail = state.data[index];
                        return TransactionDetailBox(
                          recentTransactionModel: _detail,
                          onClickAction: () {
                            context
                                .read<TransactionDownloadCubit>()
                                .generateUrl(
                                  transactionId: _detail.transactionIdentifier,
                                );

                            NavigationService.push(
                                target: TransactionDetailWidget(
                              downloadUrlNotifier: _downloadNotifierValue,
                              recentTransactionModel: _detail,
                            ));
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const NoDataScreen(
                title: "No transactions yet",
                details: "Make Your First Transfer",
              );
            }
          },
        ),
      ),
    );
  }

  dateFilterBox({required String title, required Function() onPressed}) {
    return InkWell(
      child: CustomRoundedButtom(title: title, onPressed: onPressed),
    );
  }
}
