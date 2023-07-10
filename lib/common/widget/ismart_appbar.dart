import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';

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
        height: _width * 0.135,
      );
    } else {
      return Image.asset(
        coOpLogo,
        height: _width * 0.135,
      );
    }
  }

  return AppBar(
    backgroundColor:
        Theme.of(NavigationService.context).scaffoldBackgroundColor,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: InkWell(
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
            : const CircleAvatar(
                backgroundImage: AssetImage(Assets.profilePicture),
              ),
      ),
    ),
    title: _getImageWidget(),
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
