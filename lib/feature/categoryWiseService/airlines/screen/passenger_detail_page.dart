import 'package:flutter/material.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/passenger_detail_widget.dart';

class PassengerDetailScreen extends StatelessWidget {
  const PassengerDetailScreen(
      {super.key, required this.adultCount, required this.childrenCount});
  final adultCount;
  final childrenCount;

  @override
  Widget build(BuildContext context) {
    return PassengerDetailWidget(
      adultCount: adultCount,
      childrenCount: childrenCount,
    );
  }
}
