import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/customerDetail/model/customer_detail_model.dart';
import 'package:ismart/feature/profile/widget/profile_screen_tabbar_widget.dart';

class ProfileTabbarPage extends StatefulWidget {
  final List details;

  final ValueNotifier<CustomerDetailModel?> customerDetail;

  const ProfileTabbarPage(
      {Key? key, required this.customerDetail, required this.details})
      : super(key: key);

  @override
  State<ProfileTabbarPage> createState() => _ProfileTabbarPageState();
}

class _ProfileTabbarPageState extends State<ProfileTabbarPage> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ProfileTabBarWidget(
      details: widget.details,
      customerDetail: widget.customerDetail,
    );
  }
}
