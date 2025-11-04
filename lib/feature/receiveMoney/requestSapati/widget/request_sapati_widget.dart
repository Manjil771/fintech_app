import 'package:flutter/material.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class RequestSapatiWidget extends StatelessWidget {
  const RequestSapatiWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        showAccountSelection: true,
        accountTitle: "To Account",
        body: Column(
          children: [
            CustomTextField(
              title: "Mobile Banking",
              hintText: "9XXXXXXXXX",
            ),
            CustomTextField(
              title: "Amount",
              hintText: "NPR",
            ),
            CustomTextField(
              title: "Purpose",
              hintText: "Remarks",
            )
          ],
        ),
        topbarName: "Request Sapati",
        onButtonPressed: () {
          //TODO : button directs to mpin screen
        },
        buttonName: "Proceed",
        title: "Request Sapati",
        detail: "Lend money from your friends using app",
      ),
    );
  }
}
