import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_pin_field.dart';

class TransactionPinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.verify,
                      color: Color(0xff4E4E4E),
                      height: size.height * 0.05,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      "Enter your MPIN",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text("Please enter your MPIN to proceed.",
                        style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(height: size.height * 0.04),
                    CustomPinCodeField(
                      onChanged: (p0) {},
                    ),
                    SizedBox(height: size.height * 0.04),
                    CustomRoundedButtom(title: "Proceed", onPressed: () {}),
                    SizedBox(height: size.height * 0.01),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
