import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/slugs.dart';
import 'package:ismart/common/enum/text_field_type.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/select_datapack_screen.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/screen/khane_pani_screen.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/ird/screen/ird_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/traffic_fine/screens/traffic_fine_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/insurance/LifeInsurance/screen/life_insurance_page.dart';
import 'package:ismart/feature/categoryWiseService/insurance/screen/non_life_insurance_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/common/screen/common_internet_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/pokhara_internet/screens/pokhara_internet_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/subisu/screens/subisu_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/ui/screens/find_username_internet_screen.dart';
import 'package:ismart/feature/categoryWiseService/tvPayment/commonTvPayment/screen/common_tv_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/tvPayment/screen/tv_payment_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class CategoriesWiseServicesWidget extends StatefulWidget {
  final List<ServiceList> services;
  final String uniqueIdentifier;
  final String topBarName;
  const CategoriesWiseServicesWidget(
      {Key? key,
      required this.services,
      required this.topBarName,
      required this.uniqueIdentifier})
      : super(key: key);

  @override
  State<CategoriesWiseServicesWidget> createState() =>
      _CategoriesWiseServicesWidgetState();
}

class _CategoriesWiseServicesWidgetState
    extends State<CategoriesWiseServicesWidget> {
  List<ServiceList> searchItems = [];
  Timer? _debounce;

  @override
  void initState() {
    searchItems = widget.services;
    super.initState();
  }

  _updateSearchList(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 200), () {
      final _res = widget.services
          .where((e) => e.service.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if (mounted) {
        setState(() {
          searchItems = _res;
        });
      }
    });
  }

  TextEditingController _selectedServiceCategory = TextEditingController();
  // final KeyValue? ignoreValue;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          showRoundBotton: false,
          title: "Choose Service Povider",
          body: Column(
            children: [
              const SizedBox(height: 10),
              CustomTextField(
                hintText: "Search",
                showSearchIcon: true,
                onChanged: (val) {
                  _updateSearchList(val);
                },
              ),
              const SizedBox(height: 10),
              Container(
                height: _height / 2,
                child: GridView.builder(
                    itemCount: searchItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          onTapFunction(
                              index: index,
                              uniqueIdentifier:
                                  searchItems[index].uniqueIdentifier);
                        },
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${searchItems[index].icon}",
                                    ),
                                    fit: BoxFit.cover)),
                            height: _height * 0.11,
                            width: _width * 0.25,
                          ),
                          SizedBox(height: _height * 0.01),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              searchItems[index].service.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: CustomTheme.darkerBlack,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                      );
                    }),
              ),
            ],
          ),
          showDetail: false,
          topbarName: widget.topBarName),
    );
  }

  onTapFunction({required String uniqueIdentifier, required int index}) {
    final selectedService = widget.services
        .where((e) =>
            e.uniqueIdentifier.toString().toLowerCase() == uniqueIdentifier)
        .toList();
    final servicess = searchItems[index];

    if (widget.uniqueIdentifier.toLowerCase() == Slugs.tv.toLowerCase()) {
      NavigationService.push(
          target: TvPaymentPage(
        service: servicess,
      ));
    }
    if (widget.uniqueIdentifier.toLowerCase() == "internet".toLowerCase()) {
      if (uniqueIdentifier.toLowerCase() ==
          Slugs.worldlinkPayment.toLowerCase()) {
        NavigationService.push(
            target: FindInternetUserScreen(
          service: servicess,
        ));
      } else if (uniqueIdentifier.toLowerCase() ==
          "subisu_online_topup".toLowerCase()) {
        NavigationService.push(
            target: SubisuPaymentPage(
          service: servicess,
        ));
      } else if (uniqueIdentifier.toLowerCase() ==
          "pokharainternet_topup".toLowerCase()) {
        NavigationService.push(
            target: PokharaInternetPaymentPage(
          service: servicess,
        ));
      } else {
        NavigationService.push(
            target: CommonInternetPage(
          service: servicess,
        ));
      }
    }
    if (uniqueIdentifier.toLowerCase() ==
        "khanepani_online_topup".toLowerCase()) {
      NavigationService.push(
          target: KhanePaniPage(
        service: servicess,
      ));
    }
    if (widget.uniqueIdentifier == "data_pack") {
      NavigationService.push(
          target: SelectDatapackScreen(
        service: servicess,
      ));
    }
    if (uniqueIdentifier.toLowerCase() ==
        "traffic_fine_payments".toLowerCase()) {
      NavigationService.push(
          target: TrafficFinePaymentPage(
        service: servicess,
      ));
    }

    if (widget.uniqueIdentifier.toLowerCase() == "insurance".toLowerCase()) {
      if (uniqueIdentifier.toLowerCase() ==
              "nepal_life_insurance".toLowerCase() ||
          uniqueIdentifier.toLowerCase() ==
              "reliance_life_insurance".toLowerCase() ||
          uniqueIdentifier.toLowerCase() ==
              "Union_Life_Insurance".toLowerCase() ||
          uniqueIdentifier.toLowerCase() ==
              "prabhu_life_insurance".toLowerCase() ||
          uniqueIdentifier.toLowerCase() ==
              "sura_life_insurance".toLowerCase()) {
        NavigationService.push(
            target: LifeInsurancePage(
          service: servicess,
        ));
      } else {
        NavigationService.push(
            target: CommonInsurancePage(
          service: servicess,
        ));
      }
    }
    if (uniqueIdentifier.toLowerCase() ==
        "government_revenue_payment".toLowerCase()) {
      NavigationService.push(
          target: RevenuePaymentPage(
        services: servicess,
      ));
    }
  }
}
