import 'package:flutter/material.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class TransactionLimitWidget extends StatelessWidget {
  const TransactionLimitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
      body: CommonContainer(
        body: Text("This Feature will be available in next update!"),
        topbarName: "Transaction Limit",
        showRoundBotton: false,
      ),
    );
  }
}
