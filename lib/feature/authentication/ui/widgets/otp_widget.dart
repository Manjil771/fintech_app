import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_pin_field.dart';
import 'package:ismart/common/widget/ismart_top_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class OTPWidget extends StatefulWidget {
  const OTPWidget({required this.onValueCallback});

  final Function(String) onValueCallback;

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  String otpCodeInput = "";
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _otpKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PageWrapper(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            const IsmartTopWidget(),
            SizedBox(height: size.height * 0.03),
            Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: CustomTheme.backgroundColor,
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/icons/verify your number.svg",
                    // colorFilter: const ColorFilter.mode(
                    //     Color(0XFF4E4E4E), BlendMode.srcIn),
                    height: size.height * 0.05,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    "Enter your OTP",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text("Please enter your OTP to proceed.",
                      style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: size.height * 0.04),
                  Text("Please enter your MPIN to proceed.",
                      style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: size.height * 0.03),
                  Form(
                    key: _otpKey,
                    child: CustomPinCodeField(
                      length: 6,
                      fieldHeight: 50,
                      fieldWidth: 50,
                      controller: _textController,
                      validator: (val) {
                        if (val == null) {
                          return "Please enter OTP.";
                        }
                        if (val.length < 6) {
                          return "Please enter valid OTP.";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        otpCodeInput = val;
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomRoundedButtom(
                      title: "Proceed",
                      onPressed: () {
                        if (_otpKey.currentState!.validate()) {
                          widget.onValueCallback(otpCodeInput);
                        }
                        // Get.to(() => const SetupMpin());
                      }),
                  SizedBox(height: size.height * 0.03),
                  TextButton(
                      onPressed: () {
                        // Get.offAll(() => const MainScreen());
                        // TODO Resend OTP Logic
                      },
                      child: Text(
                        "Resend",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpField extends StatefulWidget {
  const OtpField({Key? key}) : super(key: key);

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 68,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0XFFF6F6F6)),
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: const InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black, fontSize: 28),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Container(
          height: 68,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0XFFF6F6F6)),
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: const InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black, fontSize: 28),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Container(
          height: 68,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0XFFF6F6F6)),
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: const InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black, fontSize: 28),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
        Container(
          height: 68,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0XFFF6F6F6)),
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            decoration: const InputDecoration(border: InputBorder.none),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black, fontSize: 28),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    ));
  }
}
