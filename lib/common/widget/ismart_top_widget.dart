import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/util/size_utils.dart';
// import 'package:get/get.dart';
// import 'package:ismart/view/Auth/loginScreen/select_language.dart';

class IsmartTopWidget extends StatelessWidget {
  const IsmartTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;
    final repo = RepositoryProvider.of<CoOperative>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          repo.bannerImage,
          height: _height * 0.12,
        ),
        if (repo.coOperativeLogo.contains("https://") ||
            repo.coOperativeLogo.contains("http://"))
          Image.network(
            repo.coOperativeLogo,
            height: _height * 0.12,
          ),
        const Spacer(),
        InkWell(
          onTap: () {
            // TODO Manage Navigation
          },
          child: SvgPicture.asset(
            Assets.translateImage,
            height: _height * 0.03,
          ),
        ),
        SizedBox(width: 15.hp),
        SvgPicture.asset(
          Assets.groupIcon,
          height: _height * 0.03,
        ),
        SizedBox(width: 15.hp),
      ],
    );
  }
}
