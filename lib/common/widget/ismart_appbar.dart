import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';

AppBar myAppbar({bool showBackButton = false}) {
  Size size = MediaQuery.of(NavigationService.context).size;
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
    title: Image.asset(
      Assets.logoImage,
      height: size.width * 0.135,
    ),
    actions: [
      InkWell(
        onTap: () {
          // Get.to(() => const NotificationScreen());
        },
        child: SvgPicture.asset(
          Assets.notificationIcon,
          height: size.height * 0.025,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SvgPicture.asset(
          Assets.searchIcon,
          height: size.height * 0.025,
        ),
      ),
    ],
  );
}
