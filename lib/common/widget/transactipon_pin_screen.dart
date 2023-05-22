import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_pin_field.dart';

class TransactionPinScreen extends StatefulWidget {
  final Function(String) onValueCallback;

  const TransactionPinScreen({super.key, required this.onValueCallback});
  @override
  State<TransactionPinScreen> createState() => _TransactionPinScreenState();
}

class _TransactionPinScreenState extends State<TransactionPinScreen> {
  String pinValue = "";

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
                      color: const Color(0xff4E4E4E),
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
                      length: 5,
                      onChanged: (p0) {
                        pinValue = p0;
                      },
                    ),
                    SizedBox(height: size.height * 0.04),
                    CustomRoundedButtom(
                      title: "Proceed",
                      onPressed: () {
                        widget.onValueCallback(pinValue);
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextButton(
                        onPressed: () {
                          NavigationService.pop();
                        },
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
