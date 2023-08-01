import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/bank_list_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class BrokerPaymentWidget extends StatelessWidget {
  final ServiceList service;
  const BrokerPaymentWidget({Key? key, required this.service})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
      title: service.service,
      buttonName: "Proceed",
      showAccountSelection: true,
      showDetail: true,
      topbarName: service.serviceCategoryName,
      detail: service.instructions,
      body: Column(children: [
        CustomTextField(
          hintText: "Select Broker",
          title: "Select Broker",
          readOnly: true,
          // controller: _selectedBankController,
          onTap: () {
            NavigationService.push(
              target: BankListPage(
                onBankSelected: (val) {
                  NavigationService.pop();

                  // _selectedBankController.text = val.bankName;
                  // selectedBank = val;
                  // setState(() {});
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
        CustomTextField(
          title: service.labelName,
          hintText: service.labelSample,
        ),
        CustomTextField(
          title: "Client Name",
          hintText: "Saurav Chaulagain",
        ),
        CustomTextField(
          title: "Mobile Number",
          hintText: "+977",
          validator: (value) => FormValidator.validatePhoneNumber(value),
        ),
        service.priceInput
            ? CustomTextField(
                title: "Amount",
                hintText: "NPR",
              )
            : Container(),
        CustomTextField(
          title: "Remarks",
          hintText: "Remarks",
        ),
      ]),
    ));
  }
}
