import 'package:flutter/material.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/amount_utils.dart';
import 'package:ismart/common/widget/custom_icon_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/search_widget.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LocationList extends StatelessWidget {
  const LocationList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        leadingAppIcon: CustomIconButton(
          icon: Icons.close_rounded,
          shadow: false,
          backgroundColor: Colors.transparent,
          onPressed: () {
            NavigationService.pop();
          },
        ),
        title: "Renew Options",
        padding: EdgeInsets.zero,
        body: Text("hello"));
  }
}
