import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/statement/miniStatement/cubit/mini_statement_cubit.dart';
import 'package:ismart/feature/statement/miniStatement/models/mini_statement_model.dart';

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
    final _theme = Theme.of(context);
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      showAppBar: false,
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
          if (state is CommonStateSuccess<List<RecentTransactionModel>>) {
            return CommonContainer(
                showDetail: true,
                showBackBotton: false,
                showRoundBotton: false,
                body: Container(
                  height: _height * 0.65,
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final _detail = state.data[index];
                      return TransactionDetailBox(
                        status: _detail.status,
                        imageUrl: _detail.iconUrl,
                        amount: _detail.amount.toString(),
                        dateTime: _detail.date.toString(),
                        desc: _detail.serviceTo,
                        title: _detail.service,
                      );
                    },
                  ),
                ),
                showTitleText: false,
                // title: "Mini Statement",
                // detail: "Select the Account you want to view statement of.",
                topbarName: "Recent Transaction");
          } else {
            return Container(
              child: Text(state.toString()),
            );
          }
        },
      ),
    );
  }
}
