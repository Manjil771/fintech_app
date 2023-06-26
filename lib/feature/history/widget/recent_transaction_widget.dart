import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
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
            if (state is CommonDataFetchSuccess<RecentTransactionModel>) {
              return Container(
                  height: _height * 0.65,
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final _detail = state.data[index];
                      return TransactionDetailBox(
                        recentTransactionModel: _detail,
                        onClickAction: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  insetPadding:
                                      EdgeInsets.symmetric(horizontal: 18),
                                  child: Container(
                                    width: double.infinity,
                                    height: _height * 0.5,
                                    child: TransactionDetailAlertWidget(
                                        recentTransactionModel: _detail),
                                  ));
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
                  ));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
