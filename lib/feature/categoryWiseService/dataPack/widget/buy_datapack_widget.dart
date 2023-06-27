import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';

class BuyDatapackWidget extends StatelessWidget {
  BuyDatapackWidget({Key? key}) : super(key: key);
  @override
  final _formKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          title: 'Buy Data Packs',
          detail: 'Buy your data packs from here',
          showDetail: true,
          showRoundBotton: true,
          showTitleText: true,
          showAccountSelection: true,
          buttonName: 'Proceed',
          accountTitle: 'From Account',
          onButtonPressed: () {
            _formKey.currentState!.save();
            if (_formKey.currentState!.validate()) {
              NavigationService.push(
                  target: TransactionPinScreen(
                onValueCallback: (p0) {},
              ));
            }
          },
          body: Column(children: [
            Row(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      color: CustomTheme.gray,
                      borderRadius: BorderRadius.circular(18)),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ncell',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w700)),
                      Text('( 1 Day - 40 Min-Day Pack )',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: _height * 0.05,
            ),
            Form(
              key: _formKey,
              child: CustomTextField(
                title: "Mobile Number",
                hintText: "xxxxxxxxxx",
                controller: _mobileNumberController,
                validator: (value) => FormValidator.validatePhoneNumber(value),
                suffixIcon: Icons.phone_android_outlined,
                showSearchIcon: true,
                onSuffixPressed: () async {
                  String phoneNumber =
                      await SecureStorageService.appPhoneNumber;
                  _mobileNumberController.text = phoneNumber;
                },
              ),
            ),
            SizedBox(
              height: _height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payable Amount:',
                  style: _textTheme.titleLarge,
                ),
                Text(
                  'NPR 1000.00',
                  style: _textTheme.titleLarge!.copyWith(
                      color: CustomTheme.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ]),
          topbarName: 'Payment'),
    );
  }
}
