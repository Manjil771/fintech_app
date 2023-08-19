import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/cusom_rounded_image.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

AppBar myAppbar({bool showBackButton = false}) {
  final _height = SizeUtils.height;
  final _width = SizeUtils.width;

  Widget _getImageWidget() {
    String coOpLogo =
        RepositoryProvider.of<CoOperative>(NavigationService.context)
            .bannerImage;
    if (coOpLogo.contains("https://")) {
      return Image.network(
        coOpLogo,
      );
    } else {
      return Image.asset(coOpLogo);
    }
  }

  return AppBar(
    backgroundColor:
        Theme.of(NavigationService.context).scaffoldBackgroundColor,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: false,
    centerTitle: false,
    leading: ValueListenableBuilder<CustomerDetailModel?>(
        valueListenable: RepositoryProvider.of<CustomerDetailRepository>(
                NavigationService.context)
            .customerDetailModel,
        builder: (context, val, _) {
          return InkWell(
            onTap: () {
              if (showBackButton) {
                NavigationService.pop();
              } else {
                NavigationService.pushNamed(routeName: Routes.profileScreen);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: showBackButton
                  ? const Icon(Icons.arrow_back_ios)
                  : val != null && val.imageUrl.isNotEmpty
                      ? CustomRoundedImage(
                          height: 30,
                          image: val.imageUrl,
                          width: 30,
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage(
                            Assets.profilePicture,
                          ),
                        ),
            ),
          );
        }),
    title: Padding(
      padding: const EdgeInsets.all(0),
      child: _getImageWidget(),
    ),
    actions: [
      InkWell(
        onTap: () {
          // Get.to(() => const NotificationScreen());
        },
        child: SvgPicture.asset(
          Assets.notificationIcon,
          height: _height * 0.025,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SvgPicture.asset(
          Assets.searchIcon,
          height: _height * 0.025,
        ),
      ),
    ],
  );
}
