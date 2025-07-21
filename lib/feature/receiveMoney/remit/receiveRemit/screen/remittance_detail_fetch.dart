import 'package:flutter/material.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/common_container.dart';

class RemittanceDetailFetch extends StatelessWidget {
  final Map<String, dynamic> data;

  const RemittanceDetailFetch({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final details = data['details'];

    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 10,
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text("Receiver Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildRow("Name", details['receiverName']),
            _buildRow("Mobile", details['receiverMobileNumber']),
            _buildRow("City", details['receiverCity']),
            _buildRow("Country", details['receiverCountary']),
            const SizedBox(height: 16),
            const Text("Sender Information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildRow("Name", details['senderName']),
            _buildRow("Country", details['senderCountary']),
            const SizedBox(height: 16),
            const Text("Transaction Info",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildRow("PIN No", details['pinNo']),
            _buildRow("Payout Amount",
                "${details['payoutAmount']} ${details['payoutCurrency']}"),
            _buildRow("Payout Type", details['payoutType']),
            _buildRow("Date", details['txnDate']),
            _buildRow("Token ID", details['tokenId']),
          ],
        ),
        topbarName: "Remittance Detail",
        showRoundBotton: false,
        showTitleText: false,
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
