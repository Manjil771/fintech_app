import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/select_datapack_screen.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/screen/khane_pani_screen.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/traffic_fine/screens/traffic_fine_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/insurance/LifeInsurance/screen/life_insurance_page.dart';
import 'package:ismart/feature/categoryWiseService/insurance/screen/non_life_insurance_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/subisu/screens/subisu_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/ui/screens/find_username_internet_screen.dart';
import 'package:ismart/feature/categoryWiseService/governmentPayment/ird/screen/ird_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/tvPayment/screen/tv_payment_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class CategoriesWiseServicesWidget extends StatefulWidget {
  final List<Service> services;
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
          body: Container(
            height: _height * 0.6,
            child: GridView.builder(
              itemCount: widget.services.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (widget.uniqueIdentifier.toLowerCase() ==
                        "tv".toLowerCase()) {
                      NavigationService.push(
                          target: TvPaymentPage(
                        service: widget.services[index],
                      ));
                    } else if (widget.services[index].uniqueIdentifier
                            .toLowerCase() ==
                        "worldlink_online_topup".toLowerCase()) {
                      NavigationService.push(
                          target: FindInternetUserScreen(
                        service: widget.services[index],
                      ));
                    } else if (widget.services[index].uniqueIdentifier
                            .toLowerCase() ==
                        "subisu_online_topup".toLowerCase()) {
                      NavigationService.push(
                          target: SubisuPaymentPage(
                        service: widget.services[index],
                      ));
                    }
                    if (widget.services[index].uniqueIdentifier.toLowerCase() ==
                        "khanepani_online_topup".toLowerCase()) {
                      NavigationService.push(target: const KhanePaniPage());
                    }
                    if (widget.uniqueIdentifier.toLowerCase() ==
                            "data_pack".toLowerCase() ||
                        widget.uniqueIdentifier.toLowerCase() ==
                            "Data Pack".toLowerCase()) {
                      NavigationService.push(
                          target: SelectDatapackScreen(
                        serviceIdentifier: widget.services[index],
                      ));
                    }
                    if (widget.services[index].uniqueIdentifier.toLowerCase() ==
                        "traffic_fine_payments".toLowerCase()) {
                      NavigationService.push(
                          target: TrafficFinePaymentPage(
                        service: widget.services[index],
                      ));
                    }

                    if (widget.uniqueIdentifier.toLowerCase() ==
                        "insurance".toLowerCase()) {
                      if (widget.services[index].uniqueIdentifier
                                  .toLowerCase() ==
                              "nepal_life_insurance".toLowerCase() ||
                          widget.services[index].uniqueIdentifier
                                  .toLowerCase() ==
                              "reliance_life_insurance".toLowerCase()) {
                        NavigationService.push(
                            target: LifeInsurancePage(
                          service: widget.services[index],
                          companyLogo: widget.services[index].icon.toString(),
                          companyName: widget.services[index].service,
                        ));
                      } else {
                        NavigationService.push(
                            target: CommonInsurancePage(
                          service: widget.services[index],
                        ));
                      }
                    }
                    if (widget.services[index].uniqueIdentifier.toLowerCase() ==
                        "government_ird_payment".toLowerCase()) {
                      NavigationService.push(
                          target: IrdPaymentPage(
                        services: widget.services[index],
                      ));
                    }
                  },
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(
                                "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.services[index].icon}",
                              ),
                              fit: BoxFit.cover)),
                      height: _height * 0.11,
                      width: _width * 0.25,
                    ),
                    SizedBox(height: _height * 0.01),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.services[index].service.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: CustomTheme.darkerBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]),
                );
              },
            ),
          ),
          showDetail: false,
          topbarName: widget.topBarName),
    );
  }
}
