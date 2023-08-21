import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class BlueBookRenewalWidget extends StatefulWidget {
  final ServiceList service;
  BlueBookRenewalWidget({Key? key, required this.service}) : super(key: key);

  @override
  State<BlueBookRenewalWidget> createState() => _BlueBookRenewalWidgetState();
}

class _BlueBookRenewalWidgetState extends State<BlueBookRenewalWidget> {
  bool _isProvince = true;

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
          Row(
            children: [
              Expanded(
                child: CustomRoundedButtom(
                  title: "PROVINCE",
                  onPressed: () {
                    setState(() {
                      _isProvince = true;
                      print(_isProvince);
                    });
                  },
                  color: _isProvince
                      ? CustomTheme.primaryColor
                      : CustomTheme.primaryColor.withOpacity(0.6),
                ),
              ),
              SizedBox(width: 10.wp),
              Expanded(
                child: CustomRoundedButtom(
                  title: "Zone",
                  onPressed: () {
                    setState(() {});
                    _isProvince = false;
                    print(_isProvince);
                  },
                  color: _isProvince
                      ? CustomTheme.primaryColor.withOpacity(0.6)
                      : CustomTheme.primaryColor,
                ),
              )
            ],
          ),
          SizedBox(height: 10.hp),
          CustomTextField(
            title: "Province",
            hintText: "Select From List",
          ),
          if (!_isProvince)
            CustomTextField(
              title: "Zone",
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
      topbarName: widget.service.serviceCategoryName,
      title: widget.service.service,
      detail: widget.service.instructions,
    ));
  }
}
