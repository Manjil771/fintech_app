import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/ismart_top_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/models/internal_branch.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/screen/select_co_op_branch.dart';

class ActivateAccountWidget extends StatelessWidget {
  ActivateAccountWidget({Key? key}) : super(key: key);
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  InternalBranch? internalBranch;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      showAppBar: false,
      body: SafeArea(
        child: ListView(
          children: [
            IsmartTopWidget(),
            SizedBox(height: 10.hp),
            Center(
                child: Text("Activate Your Service",
                    style: _textTheme.displaySmall)),
            SizedBox(height: 10.hp),
            Center(
              child: Text(
                "Enter your registered mobile number",
                style: _textTheme.headlineSmall,
              ),
            ),
            SizedBox(height: 20.hp),
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: CustomTheme.white),
              child: Form(
                key: _fromKey,
                child: Column(
                  children: [
                    CustomTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          FormValidator.validatePhoneNumber(value),
                      controller: _mobileNumberController,
                      title: "Mobile Number",
                    ),
                    CustomTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => FormValidator.validateFieldNotEmpty(
                          value, "Account Number"),
                      controller: _accountNumberController,
                      title: "Account Number",
                    ),
                    CustomTextField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              internalBranch = val;
                              _branchController.text = val.name;
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.hp),
            CustomRoundedButtom(
                title: "Sign Up",
                onPressed: () {
                  if (_fromKey.currentState!.validate()) ;
                }),
            SizedBox(height: 10.hp),
            CustomRoundedButtom(
                title: "Cancel",
                onPressed: () {
                  NavigationService.pop();
                }),
          ],
        ),
      ),
    );
  }
}
