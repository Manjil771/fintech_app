import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_carousel.dart';
import 'package:ismart/feature/dashboard/event/screen/event_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/category_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/widget/category_widget.dart';
import 'package:ismart/feature/dashboard/notice/screen/notice_page.dart';
import 'package:ismart/feature/market/screen/market_place_screen.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';

class CategoryPage extends StatefulWidget {
  final bool showAllServices;

  const CategoryPage({
    super.key,
    required this.showAllServices,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> _bannerImages = [];
  List<String> _defaultBannerImages = [];

  @override
  void initState() {
    _bannerImages = RepositoryProvider.of<StartUpRepository>(context).banners;
    _defaultBannerImages =
        RepositoryProvider.of<StartUpRepository>(context).defaultbanners;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return BlocProvider(
      create: (context) => CategoryCubit(
        servicesRepository: RepositoryProvider.of<CategoryRepository>(context),
      )..fetchCategory(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CategoryWidget(
              showAllService: widget.showAllServices,
            ),
            // SizedBox(height: 8.hp),
            // InkWell(
            //   onTap: () {
            //     NavigationService.push(target: const MarketPlaceScreen());
            //   },
            //   child: Container(
            //       decoration: const BoxDecoration(
            //         color: CustomTheme.white,
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(10),
            //         ),
            //         border: Border(
            //           top: BorderSide(color: Colors.grey, width: 1),
            //           right: BorderSide(color: Colors.grey, width: 1),
            //         ),
            //       ),
            //       alignment: Alignment.center,
            //       width: double.infinity,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Icon(Icons.shopping_cart_outlined,
            //               color: CustomTheme.primaryColor),
            //           Text(
            //             "Market",
            //             style: TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w600,
            //                 color: CustomTheme.primaryColor),
            //           ),
            //         ],
            //       ),
            //       height: 36.hp),
            // ),
            SizedBox(height: 10.hp),
            if (_bannerImages.isNotEmpty)
              CustomCarousel(
                height: 140.hp,
                topMargin: 10,
                items: _bannerImages,
              ),
            if (_bannerImages.isEmpty && _defaultBannerImages.isNotEmpty)
              CustomCarousel(
                height: 140.hp,
                topMargin: 10,
                items: _defaultBannerImages,
              ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      NavigationService.push(target: const NoticePage());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(7, 7),
                              blurRadius: 8,
                              spreadRadius: -5,
                            ),
                          ],
                          color: CustomTheme.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.eventIcon,
                            height: 20.hp,
                            color: _theme.primaryColor,
                          ),
                          SizedBox(width: 20.wp),
                          Text(
                            LocaleKeys.event.tr(),
                            style: _textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.wp),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      NavigationService.push(target: const EventPage());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(7, 7),
                              blurRadius: 8,
                              spreadRadius: -5,
                            ),
                          ],
                          color: CustomTheme.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.loanSchedule,
                            height: 20.hp,
                            color: _theme.primaryColor,
                          ),
                          SizedBox(width: 10.wp),
                          Text(
                            LocaleKeys.notice.tr(),
                            style: _textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.hp),
          ],
        ),
      ),
    );
  }
}
