import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/notification_count_widget.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

import '../../feature/authentication/resource/user_repository.dart';

AppBar myAppbar({bool showBackButton = false, bool showChatBot = false}) {
  final _height = SizeUtils.height;

  Widget _getImageWidget() {
    final String coOpLogo =
        RepositoryProvider.of<CoOperative>(NavigationService.context)
            .bannerImage;
    if (coOpLogo.contains("https://")) {
      return Image.network(
        coOpLogo,
        height: 200,
      );
    } else {
      return Image.asset(
        coOpLogo,
        height: 50,
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
    leading: ValueListenableBuilder<CustomerDetailModel?>(
        valueListenable: RepositoryProvider.of<CustomerDetailRepository>(
                NavigationService.context)
            .customerDetailModel,
        builder: (context, val, _) {
          return InkWell(
            onTap: () {
              if (showBackButton) {
                NavigationService.pop();
              } else {}
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: showBackButton
                    ? const Icon(Icons.arrow_back_ios)
                    : Container()),
          );
        }),
    title: Padding(
      padding: const EdgeInsets.all(0),
      child: _getImageWidget(),
    ),
    actions: [
      const NotificationCountIcon(),
      InkWell(
        onTap: () {
          showPopUpDialog(
            context: NavigationService.context,
            message: "Are you sure you want to logout.",
            title: "Alert",
            buttonText: "Logout",
            buttonCallback: () {
              RepositoryProvider.of<UserRepository>(NavigationService.context)
                  .logout();
              NavigationService.pushNamedAndRemoveUntil(
                routeName: Routes.loginPage,
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: SvgPicture.asset(
            Assets.logoutIcon,
            color: CustomTheme.primaryColor,
            height: _height * 0.025,
          ),
        ),
      ),
    ],
  );
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
// import 'package:ismart/common/widget/cusom_rounded_image.dart';
// import 'package:ismart/common/widget/notification_count_widget.dart';
// import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
// import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
// import 'package:ismart/feature/notification/screen/notification_page.dart';

// AppBar myAppbar({bool showBackButton = false}) {
//   final _height = SizeUtils.height;
//   final _width = SizeUtils.width;

//   Widget _getImageWidget() {
//     String coOpLogo =
//         RepositoryProvider.of<CoOperative>(NavigationService.context)
//             .bannerImage;
//     if (coOpLogo.contains("https://")) {
//       return Image.network(
//         coOpLogo,
//         height: 200,
//       );
//     } else {
//       return Image.asset(
//         coOpLogo,
//         height: 50,
//       );
//     }
//   }

//   return AppBar(
//     backgroundColor:
//         Theme.of(NavigationService.context).scaffoldBackgroundColor,
//     elevation: 0,
//     iconTheme: const IconThemeData(color: Colors.black),
//     automaticallyImplyLeading: false,
//     centerTitle: true,
//     leading: ValueListenableBuilder<CustomerDetailModel?>(
//         valueListenable: RepositoryProvider.of<CustomerDetailRepository>(
//                 NavigationService.context)
//             .customerDetailModel,
//         builder: (context, val, _) {
//           return InkWell(
//             onTap: () {
//               if (showBackButton) {
//                 NavigationService.pop();
//               } else {
//                 NavigationService.pushNamed(routeName: Routes.profileScreen);
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: showBackButton
//                   ? const Icon(Icons.arrow_back_ios)
//                   : val != null && val.imageUrl.isNotEmpty
//                       ? CustomRoundedImage(
//                           height: 30,
//                           image: val.imageUrl,
//                           width: 30,
//                         )
//                       : const CircleAvatar(
//                           backgroundImage: AssetImage(
//                             Assets.profilePicture,
//                           ),
//                         ),
//             ),
//           );
//         }),
//     title: Padding(
//       padding: const EdgeInsets.all(0),
//       child: _getImageWidget(),
//     ),
//     actions: [
//       NotificationCountIcon(),
//       InkWell(
//         onTap: () {
//           NavigationService.pushNamed(routeName: Routes.settingPage);
//         },
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18.0),
//           child: SvgPicture.asset(
//             Assets.settingIcon,
//             color: CustomTheme.primaryColor,
//             height: _height * 0.025,
//           ),
//         ),
//       ),
//     ],
//   );
// }
