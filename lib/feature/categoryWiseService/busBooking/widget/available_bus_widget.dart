import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_detail_box.dart';
import 'package:ismart/feature/categoryWiseService/busBooking/widget/bus_topbar_location_box.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class AvailableBusWiget extends StatelessWidget {
  final ServiceList service;
  final DateTime selectedDate;
  const AvailableBusWiget(
      {Key? key, required this.service, required this.selectedDate})
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
          BusTopBarLocationBox(
            selectedDate: selectedDate,
            sectorFrom: "KATHMANDU",
            sectorTo: "POKHARA",
          ),
          Expanded(
            child: Container(
                child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BusDetailBox();
              },
            )),
          ),
        ],
      ),
    );
  }
}
