import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/file_download_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/qrCode/shareQr/resources/qr_repository.dart';

class TransactionDetailWidget extends StatefulWidget {
  final RecentTransactionModel recentTransactionModel;
  final ValueNotifier<String> downloadUrlNotifier;
  const TransactionDetailWidget({
    Key? key,
    required this.recentTransactionModel,
    required this.downloadUrlNotifier,
  }) : super(key: key);

  @override
  State<TransactionDetailWidget> createState() =>
      _TransactionDetailWidgetState();
}

class _TransactionDetailWidgetState extends State<TransactionDetailWidget> {
  String? downloadUrl;
  @override
  Widget build(BuildContext context) {
    final e = widget.recentTransactionModel;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 0,
        buttonName: "Close",
        onButtonPressed: () {
          NavigationService.pop();
        },
        showDetail: false,
        showTitleText: false,
        topbarName: "Transaction Detail",
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      widget.recentTransactionModel.service,
                      style: _textTheme.displaySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${widget.recentTransactionModel.date.year}-${widget.recentTransactionModel.date.month}-${widget.recentTransactionModel.date.day}",
                      style: _textTheme.titleLarge,
                    ),
                  ],
                ),
                CustomCachedNetworkImage(
                  fit: BoxFit.cover,
                  height: 50.hp,
                  url: RepositoryProvider.of<CoOperative>(context).baseUrl +
                      widget.recentTransactionModel.iconUrl,
                )
              ],
            ),
            SizedBox(height: 15.hp),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFFF3F3F3)),
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
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFFF3F3F3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sender Details",
                    style: _textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: _height * 0.01),
                  KeyValueTile(
                    title: "Account Number",
                    value:
                        widget.recentTransactionModel.accountNumber.toString(),
                  ),
                  KeyValueTile(
                    title: "Transaction ID",
                    value: widget.recentTransactionModel.transactionIdentifier
                        .toString(),
                  ),
                  KeyValueTile(
                    title: "Channel",
                    value: widget.recentTransactionModel.channelType
                                .toString()
                                .toLowerCase() ==
                            "GPRS".toLowerCase()
                        ? "Online"
                        : "SMS",
                  ),
                  KeyValueTile(
                    useCustomColor: true,
                    isRedColor:
                        widget.recentTransactionModel.status.toLowerCase() ==
                                "Complete".toLowerCase()
                            ? false
                            : true,
                    title: "Status",
                    value: widget.recentTransactionModel.status.toString(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.hp),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFFF3F3F3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Receiver Details",
                    style: _textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: _height * 0.01),
                  if (e.requestDetail.destinationAccountName != null)
                    Column(
                      children: [
                        KeyValueTile(
                            title: "Name",
                            value: e.requestDetail.destinationAccountName
                                .toString()),
                        KeyValueTile(
                            title: "Account Number",
                            value: e.requestDetail.destinationAccountNumber
                                .toString()),
                        KeyValueTile(
                            title: "Bank Name",
                            value:
                                e.requestDetail.destinationBankName.toString()),

                        // this.amount,
                        // this.mobileNumber,
                        // this.serviceId,
                        // this.serviceTo,
                      ],
                    ),
                  if (e.requestDetail.customerAddress != null)
                    KeyValueTile(
                        title: "Address",
                        value: e.requestDetail.customerAddress.toString()),
                  if (e.requestDetail.serviceId != null)
                    KeyValueTile(
                        title: "Service Id",
                        value: e.requestDetail.serviceId.toString()),
                  if (e.requestDetail.mobileNumber != null)
                    KeyValueTile(
                        title: "Mobile Number",
                        value: e.requestDetail.mobileNumber.toString()),
                  if (e.requestDetail.serviceTo != null)
                    KeyValueTile(
                        title: "Service To",
                        value: e.requestDetail.serviceTo.toString()),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder<String>(
                valueListenable: widget.downloadUrlNotifier,
                builder: (context, val, _) {
                  if (val.isNotEmpty) {
                    return CustomRoundedButtom(
                        title: "Download Receipt",
                        verticalPadding: 10,
                        icon: Icons.file_download_outlined,
                        onPressed: () {
                          FileDownloadUtils.downloadFile(
                            downloadLink: widget.downloadUrlNotifier.value,
                            fileName:
                                FileDownloadUtils.generateDownloadFileName(
                              name: widget.recentTransactionModel.service,
                              filetype: FileType.pdf,
                            ),
                            context: context,
                          );
                          widget.downloadUrlNotifier.value = "";
                          NavigationService.pop();
                        });
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
