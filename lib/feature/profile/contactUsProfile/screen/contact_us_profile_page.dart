import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/profile/contactUsProfile/widget/contact_us_profile_widget.dart';

class ContactUsProfilePage extends StatelessWidget {
  final List details;
  final String? latitude;
  final String? longitude;
  const ContactUsProfilePage(
      {Key? key, required this.details, this.latitude, this.longitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ContactUsProfileWidget(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      details: details,
    );
  }
}
