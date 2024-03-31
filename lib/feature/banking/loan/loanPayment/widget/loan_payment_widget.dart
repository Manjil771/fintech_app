import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/receiveMoney/models/bank.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/screen/select_co_op_branch.dart';

class LoanPaymentWidget extends StatefulWidget {
  const LoanPaymentWidget({super.key});

  @override
  State<LoanPaymentWidget> createState() => _LoanPaymentWidgetState();
}

class _LoanPaymentWidgetState extends State<LoanPaymentWidget> {
  Bank? selectedBank;
  final TextEditingController _branchController = TextEditingController();

  String? branchId;
  String? branchCode;
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        body: Column(
          children: [
            CustomTextField(
              title: "Branch",
              hintText: "Select Branch",
              readOnly: true,
              controller: _branchController,
              validator: (val) =>
                  FormValidator.validateFieldNotEmpty(val, "Branch"),
              onTap: () {
                NavigationService.push(
                  target: CoOperativeBranchPage(
                    onBankSelected: (val) {
                      NavigationService.pop();
                      branchCode = val.branchCode;
                      branchId = val.id.toString();
                      _branchController.text = val.name;
                    },
                  ),
                );
              },
            )
          ],
        ),
        topbarName: "Loan Payment",
      ),
    );
  }
}
