import 'package:flutter/material.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/available_flight_widget.dart';

class AvailableFlightScreen extends StatelessWidget {
  const AvailableFlightScreen(
      {super.key, required this.adultCount, required this.childrenCount});
  final adultCount;
  final childrenCount;

  @override
  Widget build(BuildContext context) {
    return AvailableFlightWidget(
      adultCount: adultCount,
      childrenCount: childrenCount,
    );
  }
}
