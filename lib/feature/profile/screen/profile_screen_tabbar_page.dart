import 'package:flutter/material.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/profile/widget/profile_screen_tabbar_widget.dart';

class ProfileTabbarPage extends StatelessWidget {
  final ValueNotifier<CustomerDetailModel?> customerDetail;

  const ProfileTabbarPage({super.key, required this.customerDetail});

  @override
  Widget build(BuildContext context) {
    return ProfileTabBarWidget(
      customerDetail: customerDetail,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
// import 'package:ismart/feature/profile/widget/profile_screen_tabbar_widget.dart';

// class ProfileTabbarPage extends StatelessWidget {
//   final String? latitude;
//   final String? longitude;
//   final List details;

//   final ValueNotifier<CustomerDetailModel?> customerDetail;

//   const ProfileTabbarPage(
//       {Key? key,
//       required this.customerDetail,
//       required this.details,
//        this.latitude,
//        this.longitude})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ProfileTabBarWidget(
//       latitude: latitude,
//       longitude: longitude,
//       details: details,
//       customerDetail: customerDetail,
//     );
//   }
// }
