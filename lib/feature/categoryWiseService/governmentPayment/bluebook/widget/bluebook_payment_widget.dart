import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class BlueBookRenewalWidget extends StatelessWidget {
  final ServiceList service;
  const BlueBookRenewalWidget({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
      body: Column(
        children: [
          CustomTextField(
            title: "Province",
            hintText: "Select From List",
          ),
          CustomTextField(
            title: "Vehicle Type",
            hintText: "Select From List",
          ),
          CustomTextField(
            title: "Lot No",
            hintText: "Select From List",
          ),
          CustomTextField(
            title: "Symbol",
            hintText: "Select From List",
          ),
          CustomTextField(
            title: "Vehicle No",
            hintText: "Select From List",
          ),
          CustomTextField(
            title: "Tax Payment Office",
            hintText: "Select From List",
          ),
          CustomTextField(
            title: "Mobile Number",
            hintText: "9866######",
          ),
        ],
      ),
      showDetail: true,
      buttonName: "Proceed",
      topbarName: service.serviceCategoryName,
      title: service.service,
      detail: service.instructions,
    ));
  }
}
