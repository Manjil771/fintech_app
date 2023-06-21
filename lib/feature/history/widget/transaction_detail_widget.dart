import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/file_download_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';

class TransactionDetailWidget extends StatefulWidget {
  final RecentTransactionModel recentTransactionModel;
  const TransactionDetailWidget(
      {Key? key, required this.recentTransactionModel})
      : super(key: key);

  @override
  State<TransactionDetailWidget> createState() =>
      _TransactionDetailWidgetState();
}

class _TransactionDetailWidgetState extends State<TransactionDetailWidget> {
  String? downloadUrl;
  @override
  void initState() {
    context.read<RecentTransactionCubit>().generateUrl(
        transactionId: widget.recentTransactionModel.transactionIdentifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: BlocListener<RecentTransactionCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonStateSuccess) {
            downloadUrl = state.data;
            setState(() {});
          }
        },
        child: CommonContainer(
          topbarName: "Detail",
          showDetail: false,
          buttonName: "Done",
          onButtonPressed: () {
            NavigationService.pop();
          },
          body: Column(
            children: [
              KeyValueTile(
                title: "Transaction ID",
                value: widget.recentTransactionModel.transactionIdentifier
                    .toString(),
              ),
              KeyValueTile(
                title: "Username",
                value: widget.recentTransactionModel.serviceTo.toString(),
              ),
              KeyValueTile(
                title: "Date",
                value: widget.recentTransactionModel.date.toString(),
              ),
              KeyValueTile(
                title: "Status",
                value: widget.recentTransactionModel.status.toString(),
              ),
              KeyValueTile(
                title: "Amount",
                value: widget.recentTransactionModel.totalAmount.toString(),
              ),
              KeyValueTile(
                title: "Charge",
                value: widget.recentTransactionModel.charge.toString(),
              ),
              KeyValueTile(
                title: "Total Amount",
                value: widget.recentTransactionModel.totalAmount.toString(),
              ),
              if (downloadUrl != null)
                CustomRoundedButtom(
                  title: "Export",
                  onPressed: () {
                    FileDownloadUtils.downloadFile(
                      downloadLink: downloadUrl ?? "",
                      fileName: FileDownloadUtils.generateDownloadFileName(
                        name: widget.recentTransactionModel.service,
                        filetype: FileType.pdf,
                      ),
                      context: context,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
