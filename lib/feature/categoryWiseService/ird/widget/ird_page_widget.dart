import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class IrdPageWidget extends StatefulWidget {
  const IrdPageWidget({super.key});

  @override
  State<IrdPageWidget> createState() => _IrdPageWidgetState();
}

class _IrdPageWidgetState extends State<IrdPageWidget> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        topbarName: 'Payment',
        title: 'Revenue payment',
        detail: 'Enter the required details to proceed further',
        showDetail: true,
        body: Column(
          children: [
            CustomTextField(
              title: 'EBP Number/Request Code',
              hintText: 'XXXX-XXXXX',
            ),
            CustomTextField(
              title: 'Amount',
              hintText: 'Enter the amount',
            ),
          ],
        ),
        buttonName: 'Get details',
      ),
    );
  }
}
