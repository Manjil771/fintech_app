import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/common/constant/assets.dart';

AppBar myAppbar(context) {
  Size size = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: false,
    centerTitle: true,
    leading: InkWell(
      onTap: () {
        // Get.to(() => ProfileScreen());
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
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
