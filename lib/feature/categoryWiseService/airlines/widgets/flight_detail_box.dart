import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';

class FlightDetailBox extends StatelessWidget {
  final Availability? flight;
  const FlightDetailBox({Key? key, this.flight}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    final adultFare = double.parse(flight?.adultFare ?? "0");
    final childFare = double.parse(flight?.adultFare ?? "0");

    final d = flight;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFFF3F3F3),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Expanded(
                child: KeyValueTile(
              axis: Axis.vertical,
              titleFontWeight: FontWeight.bold,
              title: d?.airline ?? "",
              value: d?.aircraftType ?? "",
            )),
            CustomCachedNetworkImage(
                url: RepositoryProvider.of<CoOperative>(context).baseUrl +
                    "ismart/airlinesPdfUrl/" +
                    "${d?.airlineImage}",
                height: 40.hp,
                fit: BoxFit.contain),
          ],
        ),
        KeyValueTile(
          title: "Destination",
          value: "${d?.departure ?? ""} - ${d?.arrival ?? ""}",
        ),
        KeyValueTile(
          title: "Date",
          value:
              "${d?.flightDate.year ?? ""}-${d?.flightDate.month}-${d?.flightDate.day ?? ""}",
        ),
        KeyValueTile(
          title: "Time",
          value: "${d?.departureTime ?? ""} - ${d?.arrivalTime ?? ""}",
        ),
        KeyValueTile(
          title: "Total Luggage",
          value: "${d?.freeBaggage ?? ""}",
        ),
        KeyValueTile(
          title: "Status",
          value: d?.refundable == "T" ? "Refundable" : 'Non Refundable',
        ),
        KeyValueTile(
          title: "${d?.adult ?? ""} Adult * ${d?.adultFare ?? ""}",
          value: (adultFare * int.parse(d?.adult ?? "0")).toString(),
        ),
        if (d?.child != "0")
          KeyValueTile(
              title: "${d?.child ?? "0"} Children * ${d?.childFare ?? "0"}",
              value: ((d?.childFare ?? "0") * int.parse(d?.child ?? "0"))
                  .toString()),
        KeyValueTile(
          title: "Fuel Charge",
          value: d?.fuelSurcharge ?? "",
        ),
        KeyValueTile(
          title: "Tax",
          value: d?.tax ?? "",
        ),
        KeyValueTile(
          title: "Total Fare",
          value: (d?.totalFare ?? 0).toString(),
        ),
      ]),
    );
  }
}
