import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_detail_box.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_location_widget.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_topbar_location_box.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class BusBillDetailWidget extends StatelessWidget {
  final BusTopBarModel busModel;
  final ServiceList service;
  final List selectedSeats;
  final selectedBusData;

  const BusBillDetailWidget(
      {Key? key,
      required this.service,
      required this.selectedBusData,
      required this.busModel,
      required this.selectedSeats})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        showBackButton: true,
        body: Column(
          children: [
            // Center(
            //   child: Image.network(
            //     "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${service.icon}",
            //     height: _height * 0.08,
            //   ),
            // ),
            // SizedBox(height: _height * 0.02),
            // Text(
            //   service.service,
            //   style: TextStyle(
            //       fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
            // ),
            BusTopBarLocationBox(busModel: busModel),
            SizedBox(height: _height * 0.01),
            const Divider(thickness: 1),
            SizedBox(height: _height * 0.01),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: _theme.primaryColor.withOpacity(0.4)),
                color: CustomTheme.white,
              ),
              // padding: EdgeInsets.all(18),
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedBusData["operator"],
                    style: _textTheme.titleSmall!.copyWith(
                        color: _theme.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.hp),
                  Text(
                      "${selectedBusData["busType"]} - ${selectedBusData["departureTime"]}",
                      style: _textTheme.titleSmall!.copyWith(
                          color: CustomTheme.darkGray,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 10.hp),
                  Text(
                    selectedBusData["amenities"].toString() != "null"
                        ? selectedBusData["amenities"].toString()
                        : "",
                    style: _textTheme.titleSmall!.copyWith(
                        // color: CustomTheme.darkGray,
                        fontSize: 11,
                        fontWeight: FontWeight.normal),
                  ),
                  Text("Selected Seats" + selectedSeats.toString()),
                ],
              ),
            )
          ],
        ));
  }
}
