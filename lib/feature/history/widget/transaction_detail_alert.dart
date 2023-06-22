import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/file_download_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';

class TransactionDetailAlertWidget extends StatefulWidget {
  final RecentTransactionModel recentTransactionModel;
  const TransactionDetailAlertWidget(
      {Key? key, required this.recentTransactionModel})
      : super(key: key);

  @override
  State<TransactionDetailAlertWidget> createState() =>
      _TransactionDetailAlertWidgetState();
}

class _TransactionDetailAlertWidgetState
    extends State<TransactionDetailAlertWidget> {
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
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: CustomTheme.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.recentTransactionModel.service,
                        style: _textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "${widget.recentTransactionModel.date.year}-${widget.recentTransactionModel.date.month}-${widget.recentTransactionModel.date.day}",
                        style: _textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      FileDownloadUtils.downloadFile(
                        downloadLink: downloadUrl ?? "",
                        fileName: FileDownloadUtils.generateDownloadFileName(
                          name: widget.recentTransactionModel.service,
                          filetype: FileType.pdf,
                        ),
                        context: context,
                      );
                    },
                    child: SvgPicture.asset(
                      Assets.downloadIcon,
                      height: _height * 0.03,
                    ),
                  ),
                ],
              ),
              SizedBox(height: _height * 0.01),
              Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Color(0xFFF3F3F3)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Billing Details",
                      style: _textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: _height * 0.01),
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
                      value:
                          widget.recentTransactionModel.totalAmount.toString(),
                    ),
                    KeyValueTile(
                      title: "Charge",
                      value: widget.recentTransactionModel.charge.toString(),
                    ),
                    KeyValueTile(
                      title: "Total Amount",
                      value:
                          widget.recentTransactionModel.totalAmount.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
