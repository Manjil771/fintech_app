import 'package:flutter/material.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';
import 'package:ismart/feature/services/internet/ui/widgets/payment_detail_widget.dart';

import '../../../../../common/util/size_utils.dart';

class InternetPaymentDeatilWidget extends StatefulWidget {
  final List<KeyValue> detailFetchData;

  const InternetPaymentDeatilWidget({super.key, required this.detailFetchData});
  @override
  State<InternetPaymentDeatilWidget> createState() =>
      _InternetPaymentDeatilWidgetState();
}

class _InternetPaymentDeatilWidgetState
    extends State<InternetPaymentDeatilWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: ListView(
        children: [
          const ScaffoldTopBar(name: "Payment"),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Internet Payment",
                  style: _textTheme.titleLarge,
                ),
                Text(
                  "Pay your internet bill of you ISP from here",
                  style: _textTheme.displaySmall,
                ),
                SizedBox(height: _height * 0.01),
                Text("From Account", style: _textTheme.titleMedium),
                Container(
                  padding: const EdgeInsets.all(18),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Details",
                        style: _textTheme.titleMedium,
                      ),
                      SizedBox(height: _height * 0.01),
                      const PaymentDetailWidget(
                          title: "Customer Name", details: "Prateek Kharel"),
                      SizedBox(height: _height * 0.008),
                      const PaymentDetailWidget(
                          title: "Customer ID", details: "pk42052"),
                      SizedBox(height: _height * 0.008),
                      const PaymentDetailWidget(
                          title: "Subscribed Package",
                          details:
                              "PHOTON Lite 200Mbps/ 12 Months (1TV) New Year "
                              "Offer"),
                      SizedBox(height: _height * 0.008),
                      const PaymentDetailWidget(
                          title: "Subscription Type", details: "Unlimited"),
                      SizedBox(height: _height * 0.008),
                      const PaymentDetailWidget(
                          title: "Days Remaining", details: "52 Days"),
                    ],
                  ),
                ),
                SizedBox(height: _height * 0.02),
                CustomTextField(title: "Amount", hintText: "Enter the amount"),
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
                    itemBuilder: (context, index) => amountBox(context, index),
                  ),
                ),
                SizedBox(height: _height * 0.03),
                CustomRoundedButtom(title: "Proceed", onPressed: () {}),
              ],
            ),
          )
        ],
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
