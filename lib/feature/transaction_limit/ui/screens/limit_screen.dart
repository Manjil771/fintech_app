import 'package:flutter/material.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/transaction_limit/ui/widgets/txn_limit_widget.dart';

class LimitScreen extends StatelessWidget {
  const LimitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      body: TransactionLimitCard(
        maxLimit: 10000,
        remaining: 100,
        title: "Limit",
        valueUnit: " ",
      ),
    );
  }
}
