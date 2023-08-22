import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/feature/history/cubit/receipt_download_cubit.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/widget/transaction_detail_alert_widget.dart';

class RecentTransactionWidget extends StatefulWidget {
  const RecentTransactionWidget({Key? key}) : super(key: key);

  @override
  State<RecentTransactionWidget> createState() =>
      _RecentTransactionWidgetState();
}

class _RecentTransactionWidgetState extends State<RecentTransactionWidget> {
  @override
  void initState() {
    super.initState();
    context.read<RecentTransactionCubit>().fetchrecentTransaction();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
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
            print("state iss ${state}");
            ValueNotifier<String> _downloadNotifierValue = ValueNotifier("");
            if (state is CommonDataFetchSuccess<RecentTransactionModel>) {
              return BlocListener<TransactionDownloadCubit, CommonState>(
                listener: (context, state) {
                  if (state is CommonStateSuccess) {
                    _downloadNotifierValue.value = state.data;
                  }
                },
                child: Container(
                    height: _height * 0.65,
                    child: ListView.builder(
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width: double.infinity,
                                    // height: _height * 0.5,
                                    child: TransactionDetailAlertWidget(
                                      recentTransactionModel: _detail,
                                      downloadUrlNotifier:
                                          _downloadNotifierValue,
                                    ),
                                  ),
                                );
                              },
                            );
                            // NavigationService.push(
                            //   target: TransactionDetailScreen(
                            //     recentTransactionModel: _detail,
                            //   ),
                            // );
                          },
                        );
                      },
                    )),
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
}
