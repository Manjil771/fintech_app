import 'package:flutter/material.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/custom_icon_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/select_datapack_screen.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/screen/khane_pani_screen.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/commonGovPayment/screen/gov_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/traffic_fine/screens/traffic_fine_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/insurance/LifeInsurance/screen/life_insurance_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/subisu/screens/subisu_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/ui/screens/find_username_internet_screen.dart';
import 'package:ismart/feature/categoryWiseService/tvPayment/screen/tv_payment_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/common/category_search_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class ServiceCategorySearchScreen extends StatelessWidget {
  final ValueChanged<KeyValue> onChanged;
  final List<ServiceList> services;
  final List<KeyValue> searchOptions;

  const ServiceCategorySearchScreen({
    Key? key,
    required this.onChanged,
    required this.searchOptions,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      leadingAppIcon: CustomIconButton(
        icon: Icons.close_rounded,
        shadow: false,
        backgroundColor: Colors.transparent,
        onPressed: () {
          NavigationService.pop();
        },
      ),
      title: "Renew Options",
      padding: EdgeInsets.zero,
      body: Container(
        child: CategorySearchWidgets(
          // imageUrl: services[0].icon.toString(),
          onPressed: () {
            onTapFunction(searchOptions[0].value, 0);
          },
          items: services,
          // items: List.generate(
          //   searchOptions.length,
          //   (index) => KeyValue(
          //     title: searchOptions[index].title,
          //     value: searchOptions[index].value,
          //   ),
          // ),
        ),
      ),
    );
  }

  onTapFunction(uniqueIdentifier, index) {
    final servicefilteredItems = services
        .where((item) => item.uniqueIdentifier
            .toString()
            .toLowerCase()
            .contains(uniqueIdentifier.toLowerCase()))
        .toList();
    if (uniqueIdentifier.toLowerCase() == "tv".toLowerCase()) {
      NavigationService.push(
          target: TvPaymentPage(
        service: servicefilteredItems[0],
      ));
    } else if (uniqueIdentifier.toLowerCase() ==
        "worldlink_online_topup".toLowerCase()) {
      NavigationService.push(
          target: FindInternetUserScreen(
        service: services[index],
      ));
    } else if (uniqueIdentifier.toLowerCase() ==
        "subisu_online_topup".toLowerCase()) {
      NavigationService.push(
          target: SubisuPaymentPage(
        service: services[index],
      ));
    }
    if (uniqueIdentifier.toLowerCase() ==
        "khanepani_online_topup".toLowerCase()) {
      NavigationService.push(
          target: KhanePaniPage(
        service: services[index],
      ));
    }
    if (uniqueIdentifier.toLowerCase() == "data_pack".toLowerCase() ||
        uniqueIdentifier.toLowerCase() == "Data Pack".toLowerCase()) {
      NavigationService.push(
          target: SelectDatapackScreen(
        service: services[index],
      ));
    }
    if (uniqueIdentifier.toLowerCase() ==
        "traffic_fine_payments".toLowerCase()) {
      NavigationService.push(
          target: TrafficFinePaymentPage(
        service: servicefilteredItems[0],
      ));
    }

    if (uniqueIdentifier.toLowerCase() ==
            "nepal_life_insurance".toLowerCase() ||
        uniqueIdentifier.toLowerCase() ==
            "reliance_life_insurance".toLowerCase()) {
      NavigationService.push(
          target: LifeInsurancePage(
        service: servicefilteredItems[0],
      ));
    }
    //  else {
    //   NavigationService.push(
    //       target: CommonInsurancePage(
    //     service: servicefilteredItems[0],
    //   ));
    // }

    if (uniqueIdentifier.toLowerCase() ==
        "government_ird_payment".toLowerCase()) {
      NavigationService.push(
          target: GovernmentPaymentPage(
        services: services[index],
      ));
    }
  }
}
