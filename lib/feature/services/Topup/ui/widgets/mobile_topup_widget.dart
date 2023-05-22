import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/dashboard/ui/screens/dashboard_page.dart';

import '../../../../../common/widget/common_button.dart';
import '../../../../../common/widget/common_text_field.dart';

class MobileTopUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: myAppbar(context),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            //const TopBar(name: "Payment", back: true),
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Mobile Top Up",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Load balance to your mobile number.",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "Select Account",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // const PrimaryAccount(),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
                              title: "Mobile Number", hintText: "9856654121")),
                      Container(
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.only(left: 8, top: 28),
                        height: size.height * 0.06,
                        width: size.width * 0.12,
                        child: SvgPicture.asset(
                            "assets/icons/Contact from phone.svg"),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  CustomTextField(
                      title: "Amount", hintText: "Enter the amount"),
                  Container(
                    padding: const EdgeInsets.only(top: 7),
                    height: size.height * 0.12,
                    width: double.infinity,
                    child: GridView.builder(
                      itemCount: 6,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 1.4 / 0.6),
                      itemBuilder: (context, index) =>
                          amountBox(context, index),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  CustomRoundedButtom(
                      title: "Done",
                      onPressed: () {
                        NavigationService.push(target: TransactionPinScreen());
                      }),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Transaction",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "View All",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: "popinmedium",
                                fontSize: 16),
                          ))
                    ],
                  )
                  // ),
                  // const MobileTransactionBox(
                  //   images: "Group 943.svg",
                  //   bank: "NTC Prepaid",
                  //   date: "abcd",
                  // ),
                  //SizedBox(height: size.height * 0.02),
                  // const MobileTransactionBox(
                  //   images: "Group 943.svg",
                  //   bank: "NTC Prepaid",
                  //   date: "abcd",
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  amountBox(context, index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black),
      ),
      child: Center(child: Text(amount[index].toString())),
    );
  }

  destinationAccount(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CustomTextField(
            title: "Destination Account",
            hintText: "Destination Account Number"),
        SizedBox(height: size.height * 0.02),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0XFFF3F3F3),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Account Holder's Name",
          ),
        ),
      ],
    );
  }

  final List amount = [100, 200, 500, 1000, 2000, 5000];
}

// Expanded(
// child: SvgPicture.asset(
// "assets/icons/Contact from phone.svg"))
