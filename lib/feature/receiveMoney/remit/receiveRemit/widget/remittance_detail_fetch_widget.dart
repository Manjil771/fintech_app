import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/allremittance_details_page.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class RemittanceDetailFetchWidget extends StatelessWidget {
  final UtilityResponseData data;
  final String path;
  final String bankName;

  const RemittanceDetailFetchWidget(
      {Key? key,
      required this.data,
      required this.path,
      required this.bankName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;

    return PageWrapper(
      showBackButton: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomTheme.white,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  path,
                  height: _height * 0.08,
                ),
                SizedBox(height: _height * 0.02),
                Text(
                  bankName,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: _height * 0.02),
                Text(
                    "Details about the payable amount for the service of   is shown below.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: _height * 0.02),
                const Divider(thickness: 1),
                SizedBox(height: _height * 0.02),
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
                      Text("Transaction Details",
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: _height * 0.02),
                      KeyValueTile(
                          title: "Receiver Name",
                          value: data.details
                                  .firstWhere(
                                      (val) => val.title == 'receiverName')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Receiver Mobile Number",
                          value: data.details
                                  .firstWhere((val) =>
                                      val.title == 'receiverMobileNumber')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Receiver City",
                          value: data.details
                                  .firstWhere(
                                      (val) => val.title == 'receiverCity')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Receiver Country",
                          value: data.details
                                  .firstWhere(
                                      (val) => val.title == 'receiverCountary')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Sender Name",
                          value: data.details
                                  .firstWhere(
                                      (val) => val.title == 'senderName')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Sender Country",
                          value: data.details
                                  .firstWhere(
                                      (val) => val.title == 'senderCountary')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "PIN No",
                          value: data.details
                                  .firstWhere((val) => val.title == 'pinNo')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Payout Amount",
                          value: data.details
                                  .firstWhere(
                                      (val) => val.title == 'payoutAmount')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Payout Currency",
                          value: data.details
                                  .firstWhere(
                                      (val) => val.title == 'payoutCurrency')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Payout Type",
                          value: data.details
                                  .firstWhere(
                                      (val) => val.title == 'payoutType')
                                  .value ??
                              ""),
                      KeyValueTile(
                          title: "Transaction Date",
                          value: data.details
                                  .firstWhere((val) => val.title == 'txnDate')
                                  .value ??
                              ""),
                    ],
                  ),
                ),
                SizedBox(height: _height * 0.02),
                CustomRoundedButtom(
                    title: "Procced",
                    onPressed: () {
                      NavigationService.push(
                          target: const AllremittanceDetailsPage());
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120,
              child: Text("$title:",
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
              child: Text(value ?? "-",
                  style: const TextStyle(fontWeight: FontWeight.normal))),
        ],
      ),
    );
  }
}
