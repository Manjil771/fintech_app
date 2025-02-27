import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/chatBot/smart_chat_page.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/screen/homepage_money_page.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/smartloan/widget/smart_loan_banner_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
// import 'package:lottie/lottie.dart';

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
  // ignore: unused_field
  List<String> _bannerImages = [];

  _checkMenu() {
    final List<String> _clientCodesListForDifferentMenu = [
      "9DZS5N3TOY", // Uttarganga
    ];

    String _clientCode = "";
    _clientCode = RepositoryProvider.of<CoOperative>(context).clientCode;

    _shouldShowDifferentMenu =
        _clientCodesListForDifferentMenu.contains(_clientCode);
    print(_shouldShowDifferentMenu);
  }

  ValueNotifier<CustomerDetailModel?> customerDetail = ValueNotifier(null);

  @override
  void initState() {
    _bannerImages = RepositoryProvider.of<StartUpRepository>(context).banners;
    customerDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .customerDetailModel;
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ValueListenableBuilder<CustomerDetailModel?>(
                valueListenable: customerDetail,
                builder: (context, val, _) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const HomePageUserWidget(),
                      SizedBox(height: _height * 0.02),
                      if ((val?.instaLoanEnable ?? false) == true)
                        const SmartLoanBannerWidget(),
                      if (_shouldShowDifferentMenu)
                        Container(
                            height: 120.hp, child: const HomePageMoneyPage()),
                      if (!_shouldShowDifferentMenu)
                        Row(
                          children: [
                            Expanded(
                                child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                NavigationService.pushNamed(
                                  routeName: Routes.loadFromKhalti,
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
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
                                      style: _textTheme.titleLarge!
                                          .copyWith(fontSize: 12),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
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
                                        backgroundColor: _theme.primaryColor
                                            .withOpacity(0.05),
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
                  );
                },
              ),
            ),
            FutureBuilder(
                future: SharedPref.getChatBotVisibility(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final isChatBotVisible = snapshot.data ?? true;
                  return isChatBotVisible
                      ? Positioned(
                          bottom: 5,
                          right: 7,
                          child: InkWell(
                            onTap: () {
                              onButtonPressed();
                            },
                            child:
                                BlocListener<UtilityPaymentCubit, CommonState>(
                              listener: (context, state) {
                                if (state is CommonStateSuccess<
                                    UtilityResponseData>) {
                                  final UtilityResponseData response =
                                      state.data;
                                  if (response.code == "M0000") {
                                    NavigationService.push(
                                      target: SmartChatPage(
                                        id: response.detail['id'],
                                      ),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomTheme.white,
                                  border: Border.all(
                                    color: CustomTheme.primaryColor
                                        .withOpacity(.7),
                                    width: 1.0,
                                  ),
                                ),
                                child: const ClipOval(
                                  child: AnimatedLogo(
                                    logoPath: "assets/smart_fuchee.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }

  onButtonPressed() {
    context.read<UtilityPaymentCubit>().fetchDetailsPost(
        serviceIdentifier: "",
        accountDetails: {},
        apiEndpoint: "api/ai/create");
  }
}

class AnimatedLogo extends StatefulWidget {
  final String logoPath;

  const AnimatedLogo({
    Key? key,
    required this.logoPath,
  }) : super(key: key);

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.05, end: 1.10).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: -0.02, end: 0.02).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Image.asset(
                  widget.logoPath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
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