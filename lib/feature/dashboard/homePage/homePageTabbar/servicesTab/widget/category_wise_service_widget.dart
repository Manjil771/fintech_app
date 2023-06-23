import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/categoryWiseService/tvPayment/screen/tv_payment_page.dart';

class CategoriesWiseServicesWidget extends StatefulWidget {
  final List<Service> services;
  final String topBarName;
  const CategoriesWiseServicesWidget(
      {Key? key, required this.services, required this.topBarName})
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
          title: "Choose Service Provider",
          body: Container(
            height: _height * 0.6,
            child: GridView.builder(
              itemCount: widget.services.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    NavigationService.push(
                        target: TvPaymentPage(
                      companyLogo: widget.services[index].icon.toString(),
                      companyName: widget.services[index].service,
                    ));
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
                          style: TextStyle(
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
