import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/banking/loan/screen/loan_page.dart';
import 'package:ismart/feature/banking/loan/widget/loan_account_box.dart';

class ChooseAccountLoanWidget extends StatefulWidget {
  const ChooseAccountLoanWidget.ChooseLoanAccountWidget({Key? key})
      : super(key: key);

  @override
  State<ChooseAccountLoanWidget> createState() =>
      _ChooseAccountLoanWidgetState();
}

class _ChooseAccountLoanWidgetState extends State<ChooseAccountLoanWidget> {
  String selectedAccountNumber = "test";

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        showAccountSelection: false,
        accountTitle: "Select Account",
        topbarName: "Loan",
        detail: "Select the Account you want to view loan detail.",
        buttonName: "Proceed",
        onButtonPressed: () {
          NavigationService.pushReplacement(
              target: LoanPage(
            accountNumber: selectedAccountNumber,
          ));
        },
        body: LoanAccountBox(
          onPressed: (p0) {
            selectedAccountNumber = p0;
            setState(() {});
            NavigationService.pushReplacement(
                target: LoanPage(
              accountNumber: selectedAccountNumber,
            ));
          },
        ),
      ),
    );
  }
}
