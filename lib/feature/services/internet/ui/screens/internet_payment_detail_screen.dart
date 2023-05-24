import 'package:flutter/material.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/feature/services/internet/ui/widgets/internet_payment_detail_widget.dart';

class InternetPaymentDeatilScreen extends StatelessWidget {
  final List<KeyValue> detailFetchData;

  const InternetPaymentDeatilScreen({super.key, required this.detailFetchData});
  @override
  Widget build(BuildContext context) {
    return InternetPaymentDeatilWidget(
      detailFetchData: detailFetchData,
    );
  }
}
