import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class CommonTransactionSuccessfulPage extends StatelessWidget {
  const CommonTransactionSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PageWrapper(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      showAppBar: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(18),
          color: CustomTheme.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                "assets/icons/circleroundcheck.svg",
                color: Color(0XFF24BC7C),
                height: size.height * 0.05,
              ),
              const Text(
                "Transaction Successful",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                  "Dear Pawan, your payment of NPR 40000 with charge 10 from "
                  "A/C 165###09887 for 9800000000 was sucessful",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall),
              const Divider(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFF3F3F3),
                  // border: Border.all(color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Paymet Details",
                        style: Theme.of(context).textTheme.titleLarge),
                    internetDetailRow(
                        context, "Date/Time", "30 Mar 2023, 06:56 PM"),
                    internetDetailRow(context, "Channel", "Online"),
                    internetDetailRow(context, "Payment Attribute",
                        "9800000000/XXXX Payment"),
                    internetDetailRow(context, "Service Name", "XXXXX"),
                    internetDetailRow(context, "Amount", "10005.00"),
                    internetDetailRow(context, "Initiator", "Initiator")
                  ],
                ),
              ),
              const Divider(height: 20),
              CustomRoundedButtom(title: "Go back to Home", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  internetDetailRow(context, name, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          width: SizeUtils.width * 0.25,
          child: Text(
            "$name:",
            style: const TextStyle(
                fontFamily: "popinmedium",
                fontSize: 12,
                color: Color(0XFF989898)),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
