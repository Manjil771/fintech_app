import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/profile/accountListProfile/screen/acoount_list_profile_page.dart';
import 'package:ismart/feature/profile/contactUsProfile/screen/contact_us_profile_page.dart';
import 'package:ismart/feature/profile/generalInfoProfile/screen/general_info_profile_page.dart';

class ProfileTabBarWidget extends StatefulWidget {
  final ValueNotifier<CustomerDetailModel?> customerDetail;

  const ProfileTabBarWidget({Key? key, required this.customerDetail})
      : super(key: key);

  @override
  State<ProfileTabBarWidget> createState() => _ProfileTabBarWidgetState();
}

class _ProfileTabBarWidgetState extends State<ProfileTabBarWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Color(0xFF989898),
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              indicatorColor: Colors.transparent,
              automaticIndicatorColorAdjustment: true,
              tabs: [
                Tab(text: "General Info"),
                Tab(text: "Account List"),
                Tab(text: "Contact Us"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  GeneralInfoProfilePage(
                    customerDetail: widget.customerDetail,
                  ),
                  AccountListProfilePage(customerDetail: widget.customerDetail),
                  const ContactUsProfilePage(),
                ],
              ),
            )
          ],
        ));
  }
}
