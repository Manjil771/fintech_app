import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/screen/homepage_money_page.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';

import '../../../splash/resource/startup_repository.dart';
import 'home_page_tabbar_widget.dart';
import 'home_page_user_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  bool _shouldShowDifferentMenu = false;
  List<String> _bannerImages = [];

  _checkMenu() {
    List<String> _clientCodesListForDifferentMenu = [
      "9DZS5N3TOY", // Uttarganga
    ];

    String _clientCode = "";
    _clientCode = RepositoryProvider.of<CoOperative>(context).clientCode;

    _shouldShowDifferentMenu =
        _clientCodesListForDifferentMenu.contains(_clientCode);
    print(_shouldShowDifferentMenu);
  }

  @override
  void initState() {
    _bannerImages = RepositoryProvider.of<StartUpRepository>(context).banners;
    _checkMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      padding: EdgeInsets.zero,
      showAppBar: false,
      body: RefreshIndicator(
        onRefresh: () async {
          NavigationService.pushReplacement(target: const DashboardPage());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const HomePageUserWidget(),
              SizedBox(height: _height * 0.02),
              if (_shouldShowDifferentMenu)
                Container(height: 68.hp, child: const HomePageMoneyPage()),
              if (!_shouldShowDifferentMenu)
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        NavigationService.pushNamed(
                            routeName: Routes.reveiveMoney);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 7),
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
                            CircleAvatar(
                              backgroundColor:
                                  _theme.primaryColor.withOpacity(0.05),
                              child: SvgPicture.asset(
                                Assets.reveiceMoneyIcon,
                                height: 18.hp,
                                color: _theme.primaryColor,
                              ),
                            ),
                            SizedBox(width: _width * 0.02),
                            Text(
                              "Receive",
                              style:
                                  _textTheme.titleLarge!.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    )),
                    SizedBox(width: _width * 0.1),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          NavigationService.pushNamed(
                              routeName: Routes.sendMoney);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 7),
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
                              CircleAvatar(
                                backgroundColor:
                                    _theme.primaryColor.withOpacity(0.05),
                                child: SvgPicture.asset(
                                  Assets.sendMoneyIcon,
                                  height: 22.hp,
                                  color: _theme.primaryColor,
                                ),
                              ),
                              SizedBox(width: _width * 0.02),
                              Text(
                                "Send",
                                style: _textTheme.titleLarge!
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const HomePageTabbarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ismart/app/theme.dart';
// import 'package:ismart/common/constant/assets.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/route/routes.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/feature/dashboard/homePage/screen/homepage_money_page.dart';

// import '../../../../common/widget/custom_carousel.dart';
// import '../../../splash/resource/startup_repository.dart';
// import 'home_page_tabbar_widget.dart';
// import 'home_page_user_widget.dart';

// class HomePageWidget extends StatefulWidget {
//   const HomePageWidget({Key? key}) : super(key: key);

//   @override
//   State<HomePageWidget> createState() => _HomePageWidgetState();
// }

// class _HomePageWidgetState extends State<HomePageWidget> {
//   bool _shouldShowDifferentMenu = false;
//   List<String> _bannerImages = [];

//   _checkMenu() {
//     List<String> _clientCodesListForDifferentMenu = [
//       "9DZS5N3TOY", // Uttarganga
//     ];

//     String _clientCode = "";
//     _clientCode = RepositoryProvider.of<CoOperative>(context).clientCode;

//     _shouldShowDifferentMenu =
//         _clientCodesListForDifferentMenu.contains(_clientCode);
//     print(_shouldShowDifferentMenu);
//   }

//   @override
//   void initState() {
//     _bannerImages = RepositoryProvider.of<StartUpRepository>(context).banners;
//     _checkMenu();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     return PageWrapper(
//       padding: EdgeInsets.zero,
//       showAppBar: false,
//       body: Column(
//         children: [
//           const HomePageUserWidget(),
//           SizedBox(height: _height * 0.02),
//           if (_shouldShowDifferentMenu)
//             Container(height: 68.hp, child: const HomePageMoneyPage()),
//           if (!_shouldShowDifferentMenu)
//             Row(
//               children: [
//                 Expanded(
//                     child: InkWell(
//                   borderRadius: BorderRadius.circular(12),
//                   onTap: () {
//                     NavigationService.pushNamed(routeName: Routes.reveiveMoney);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: CustomTheme.white,
//                         borderRadius: BorderRadius.circular(12)),
//                     height: _height * 0.08,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           backgroundColor:
//                               _theme.primaryColor.withOpacity(0.05),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SvgPicture.asset(
//                               Assets.reveiceMoneyIcon,
//                               color: _theme.primaryColor,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: _width * 0.02),
//                         Text(
//                           "Receive",
//                           style: _textTheme.titleLarge,
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
//                 SizedBox(width: _width * 0.1),
//                 Expanded(
//                     child: InkWell(
//                   borderRadius: BorderRadius.circular(12),
//                   onTap: () {
//                     NavigationService.pushNamed(routeName: Routes.sendMoney);
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: CustomTheme.white,
//                         borderRadius: BorderRadius.circular(12)),
//                     height: _height * 0.08,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           backgroundColor:
//                               _theme.primaryColor.withOpacity(0.05),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: SvgPicture.asset(
//                               Assets.sendMoneyIcon,
//                               color: _theme.primaryColor,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: _width * 0.02),
//                         Text(
//                           "Send",
//                           style: _textTheme.titleLarge,
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
//               ],
//             ),
//           const Expanded(child: HomePageTabbarWidget()),
//           // if (_bannerImages.isNotEmpty)
//           //   CustomCarousel(
//           //     height: 140.hp,
//           //     topMargin: 10,
//           //     items: _bannerImages,
//           //   ),
//         ],
//       ),
//     );
//   }
// }