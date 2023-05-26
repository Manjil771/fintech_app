import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/profile/screen/profile_screen_tabbar_page.dart';

import '../../../app/theme.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              NavigationService.pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          Container(
            decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(18)),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Row(children: [
              const CircleAvatar(
                radius: 50,
                //TODO: need to add user profile picture from api
                backgroundImage: AssetImage(Assets.profilePicture),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pawan Sharma",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        "pawan@ismart.com.np",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        "Gaurighatmarg-07, KTM",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: _height * 0.01),
          const Expanded(child: ProfileTabbarPage())
        ],
      ),
    );
  }
}
