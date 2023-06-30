import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/ui/screen/gov_place_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/receiveMoney/models/bank.dart';

class TrafficFinePaymentWidget extends StatefulWidget {
  final Service service;

  const TrafficFinePaymentWidget({Key? key, required this.service})
      : super(key: key);

  @override
  State<TrafficFinePaymentWidget> createState() =>
      _TrafficFinePaymentWidgetState();
}

class _TrafficFinePaymentWidgetState extends State<TrafficFinePaymentWidget> {
  final TextEditingController _selectedProvinceNameController =
      TextEditingController();
  final TextEditingController _selectedDistrictController =
      TextEditingController();
  String? selectedDistrictValue;
  String? selectedProvinceValue;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          title: widget.service.service,
          detail: widget.service.instructions,
          showDetail: true,
          topbarName: "Payment",
          body: Column(
            children: [
              CustomTextField(
                hintText: "Select Bank",
                title: "Select Bank",
                readOnly: true,
                controller: _selectedProvinceNameController,
                onTap: () {
                  NavigationService.push(
                    target: GovPlacePage(
                      isProvince: true,
                      accountDetails: {},
                      apiEndpoint: "/api/governmentpayment/getProvance",
                      serviceIdentifier: "",
                      onBankSelected: ({required value, required name}) {
                        NavigationService.pop();
                        _selectedProvinceNameController.text = name;
                        selectedProvinceValue = value;

                        setState(() {});
                      },
                    ),
                  );
                },
                validator: (value) {},
              ),
              CustomTextField(
                hintText: "Select Bank",
                title: "Select Bank",
                readOnly: true,
                controller: _selectedDistrictController,
                onTap: () {
                  NavigationService.push(
                    target: GovPlacePage(
                      isProvince: false,
                      accountDetails: {
                        "provinceId": selectedProvinceValue,
                      },
                      apiEndpoint: "/api/governmentpayment/getDistrict",
                      serviceIdentifier: "",
                      onBankSelected: ({required value, required name}) {
                        NavigationService.pop();
                        _selectedDistrictController.text = name;
                        selectedDistrictValue = value;
                        setState(() {});
                      },
                    ),
                  );
                },
                validator: (value) {
                  // if (selectedBank != null) {
                  //   return null;
                  // } else {
                  //   return "Please select destination bank.";
                  // }
                },
              ),
            ],
          )),
    );
  }
}
