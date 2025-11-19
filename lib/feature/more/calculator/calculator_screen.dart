import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/more/dateCalculator/date_calculator_page.dart';
import 'package:ismart/feature/more/discountCalculator/discount_calculator_page.dart';
import 'package:ismart/feature/more/emiCalculator/emi_calculator_page.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final ValueNotifier<bool> _isBiometricEnabled = ValueNotifier(false);

  // bool switchValue = false;

  @override
  void initState() {
    _checkBiometric();

    super.initState();
  }

  _checkBiometric() async {
    final bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
    if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
      _isBiometricEnabled.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWrapper(
        body: CommonContainer(
          showDetail: false,
          showTitleText: false,
          showRoundBotton: false,
          verticalPadding: 0,
          topbarName: "Calculator".tr(),
          body: Column(
            children: [
              CommonDetailBox(
                  leadingImage: Assets.discountCalculator,
                  onBoxPressed: () {
                    NavigationService.push(
                        target: const DiscountCalculatorPage());
                  },
                  detail: "",
                  title: "Discount Calculator".tr()),
              const Divider(thickness: 1),
              CommonDetailBox(
                  leadingImage: Assets.emiCalculator,
                  onBoxPressed: () {
                    NavigationService.push(target: const EmiCalculatorPage());
                  },
                  detail: "",
                  title: "EMI Calculator".tr()),
              const Divider(thickness: 1),
              CommonDetailBox(
                  leadingImage: Assets.calenderIconDark,
                  onBoxPressed: () {
                    NavigationService.push(target: const DateCalculatorPage());
                  },
                  detail: "",
                  title: "Date Converter".tr()),
              const Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
