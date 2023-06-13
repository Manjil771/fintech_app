import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/transaction_limit/ui/widgets/txn_limit_widget.dart';

class LimitScreen extends StatelessWidget {
  const LimitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return  PageWrapper(
      body: TransactionLimitCard(
        maxLimit: 10000,
        remaining: 100,
        title: "Limit",
        valueUnit: " ",
      ),
    );
  }
}
