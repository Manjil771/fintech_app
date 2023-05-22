import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          backgroundImage: AssetImage(
              "assets/images/184451271-senior-man-avatar-smiling-elderly-man-with-beard-with-gray-hair-3d-vector-people-character-illustrat 1.png"),
        ),
      ),
    ),
    title: Image.asset(
      "assets/ismartlogo.png",
      height: size.width * 0.135,
    ),
    actions: [
      InkWell(
        onTap: () {
          // Get.to(() => const NotificationScreen());
        },
        child: SvgPicture.asset(
          "assets/icons/Notification.svg",
          height: size.height * 0.025,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SvgPicture.asset(
          "assets/icons/search.svg",
          height: size.height * 0.025,
        ),
      ),
    ],
  );
}
