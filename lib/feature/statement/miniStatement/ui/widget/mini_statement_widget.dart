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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context
          .read<MiniStatementCubit>()
          //.fetchMiniStatement(accountNumbner: "001001-001-102-0001002");
          .fetchMiniStatement(accountNumbner: "001GS4000386");
    });
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
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
            return CommonContainer(
                body: DataTable(
                  columns: [
                    DataColumn(label: Text("Remarks")),
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Amount")),
                  ],
                  rows: state.data.ministatementList
                      .map((e) => DataRow(
                            cells: [
                              DataCell(Text(e.transactionDate.toString())),
                              DataCell(Text(e.transactionDate.toString())),
                              DataCell(Text(e.amount.toString())),
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
                onButtonPressed: () {
                  NavigationService.push(target: DashboardPage());
                },
                buttonName: "Close",
                title: "Mini Statement",
                detail: "Select the Account you want to view statement of.",
                topbarName: "Statement");
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
