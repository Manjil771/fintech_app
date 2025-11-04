import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/more/transactionLimit/transaction_progress_page.dart';

class TransactionLimitWidget extends StatefulWidget {
  const TransactionLimitWidget({super.key});

  @override
  State<TransactionLimitWidget> createState() => _TransactionLimitWidgetState();
}

class _TransactionLimitWidgetState extends State<TransactionLimitWidget> {
  bool showCount = true;
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        showBackButton: true,
        body: SingleChildScrollView(
          // child: CommonContainer(
          //     body: Text(
          //       "Working , will be availbale in next update",
          //       style: TextStyle(color: Colors.black),
          //     ),
          //     topbarName: "Transition limit"),
          child: Column(
            children: [
              TransactionProgressPage(
                title: "Internal Fund Transfer".tr(),
                profileType: 'CustomerProfile',
                isOpen: true,
              ),
              TransactionProgressPage(
                title: "Wallet".tr(),
                profileType: 'WalletProfile',
                isOpen: false,
              ),
              TransactionProgressPage(
                title: "Bank Transfer".tr(),
                profileType: 'BankTransferProfile',
                isOpen: false,
              ),
              TransactionProgressPage(
                title: "Scan and Pay Profile".tr(),
                profileType: 'QRProfile',
                isOpen: false,
              ),
              // TransactionProgressPage(
              //   title: "iBanking",
              //   profileType: 'IBankingProfile',
              //   isOpen: false,
              // ),
            ],
          ),
        ));
  }
}
