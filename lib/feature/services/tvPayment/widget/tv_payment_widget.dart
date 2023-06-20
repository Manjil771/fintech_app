import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_text_field.dart';

class TvPaymentWidget extends StatelessWidget {
  TvPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(18),
                      bottomLeft: Radius.circular(18))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "TV Payment",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Pay for your insurance bill from here.",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: _height * 0.01),
                  Text("Select Account",
                      style: Theme.of(context).textTheme.titleMedium),
                  CustomTextField(
                      title: "Chip ID/ Account No/ CAS ID",
                      hintText: "Select your Account"),
                  SizedBox(height: _height * 0.01),
                  CustomTextField(
                      title: "Amount", hintText: "Enter the amount"),
                  SizedBox(height: _height * 0.01),
                  Container(
                    padding: const EdgeInsets.only(top: 7),
                    height: _height * 0.12,
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
                  SizedBox(height: _height * 0.04),
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

  final List amount = [100, 200, 500, 1000, 2000, 5000];
}
