import 'package:flutter/material.dart';
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
    return const PageWrapper(
        body: SingleChildScrollView(
      child: Column(
        children: [
          TransactionProgressPage(
            title: "Customer",
            profileType: 'CustomerProfile',
            isOpen: true,
          ),
          TransactionProgressPage(
            title: "Wallet",
            profileType: 'WalletProfile',
            isOpen: false,
          ),
          TransactionProgressPage(
            title: "Bank Transfer",
            profileType: 'BankTransferProfile',
            isOpen: false,
          ),
          TransactionProgressPage(
            title: "QR",
            profileType: 'QRProfile',
            isOpen: false,
          ),
          TransactionProgressPage(
            title: "iBanking",
            profileType: 'IBankingProfile',
            isOpen: false,
          ),
        ],
      ),
    ));
  }
}
