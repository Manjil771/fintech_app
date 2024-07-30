import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
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
    context.read<RecentTransactionCubit>().fetchrecentTransaction(
        serviceCategoryId: "", associatedId: "", serviceId: "");
  }

  getRecentTransaction(DateTime fromDate, DateTime toDate) {
    context.read<RecentTransactionCubit>().fetchrecentTransaction(
        serviceCategoryId: "", associatedId: "", serviceId: "");
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
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
