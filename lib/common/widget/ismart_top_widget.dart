import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
// import 'package:get/get.dart';
// import 'package:ismart/view/Auth/loginScreen/select_language.dart';

class IsmartTopWidget extends StatelessWidget {
  const IsmartTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          Assets.logoImage,
          height: size.height * 0.08,
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            // TODO Manage Navigation
          },
          child: SvgPicture.asset(
            Assets.translateImage,
            height: size.height * 0.03,
          ),
        ),
        SizedBox(
          width: 15.hp,
        ),
        SvgPicture.asset(
          Assets.groupIcon,
          height: size.height * 0.03,
        ),
        SizedBox(
          width: 15.hp,
        ),
      ],
    );
  }
}
