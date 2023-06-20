import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/services_model.dart';

class ListServicesScreen extends StatelessWidget {
  final List<Service> services;
  final String topBarName;
  const ListServicesScreen(
      {Key? key, required this.services, required this.topBarName})
      : super(key: key);
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
              itemCount: services.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: CustomTheme.darkerBlack.withOpacity(0.07)),
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        height: _height * 0.08,
                        child: SvgPicture.network(
                          RepositoryProvider.of<CoOperative>(context).baseUrl +
                              "/ismart/serviceIcon/" +
                              services[index].uniqueIdentifier.toString(),
                          color: CustomTheme.darkerBlack.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: _height * 0.01),
                      Expanded(
                        child: Text(
                          services[index].uniqueIdentifier.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: CustomTheme.darkerBlack.withOpacity(0.6),
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
          showDetail: false,
          topbarName: topBarName),
    );
  }
}
