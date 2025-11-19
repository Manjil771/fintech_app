import 'package:flutter/material.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class QrREsponseWidget extends StatelessWidget {
  final result;
  const QrREsponseWidget({Key? key, this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
          showAccountSelection: true,
          body: Column(
            children: [
              Text(result.toString()),
              CustomTextField(
                title: "Destination Account Number",
                hintText: "XXXXXXX",
              ),
              CustomTextField(
                title: "Amount",
                hintText: "NPR",
              ),
              CustomTextField(
                title: "Remarks",
                hintText: "Remarks",
              ),
            ],
          ),
          showDetail: false,
          topbarName: "Payment"),
    );
  }
}
