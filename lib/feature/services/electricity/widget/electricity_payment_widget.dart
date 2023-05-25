import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class ElectricityPaymentWidget extends StatelessWidget {
  const ElectricityPaymentWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        title: "NEA Payment",
        detail: "Pay for your electricity bill from here.",
        body: Column(
          children: [
            CustomTextField(
              title: "Select Counter",
              hintText: "Select From List", //Need to add dropdown button
            ),
            CustomTextField(
              title: "SC No.",
              hintText: "Enter SC Number", //Need to add dropdown button
            ),
            CustomTextField(
              title: "Customer Id",
              hintText: "ID", //Need to add dropdown button
            ),
          ],
        ),
        buttonName: "Procced",
        onButtonPressed: () {
          NavigationService.pushNamed(
              routeName: Routes.electricityPaymentDetail);
        },
        topbarName: "Payment",
      ),
    );
  }
}
