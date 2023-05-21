import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/constant/assets.dart';
// import 'package:get/get.dart';
// import 'package:ismart/view/Auth/loginScreen/select_language.dart';

class IsmartTopWidget extends StatelessWidget {
  const IsmartTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Image.asset(
          Assets.logoImage,
          height: size.height * 0.08,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            // Get.to(() => const SelectLanguage());

            // TODO Manage Navigation
          },
          child: SvgPicture.asset(
            Assets.translateImage,
            height: size.height * 0.03,
          ),
        ),
        SizedBox(width: size.width * 0.02),
        SvgPicture.asset(
          Assets.groupIcon,
          height: size.height * 0.03,
        ),
      ],
    );
  }
}
