import 'package:flutter/material.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';

import '../../../../../common/route/routes.dart';
import '../../../../../common/util/size_utils.dart';

class FindInternetUserWidget extends StatefulWidget {
  @override
  State<FindInternetUserWidget> createState() => _FindInternetUserWidgetState();
}

class _FindInternetUserWidgetState extends State<FindInternetUserWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: Column(
        children: [
          const ScaffoldTopBar(name: "Payment", back: true),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Internet Payment",
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  "Pay your internet bill of you ISP from here",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: _height * 0.03),
                Row(
                  children: [
                    Container(
                      height: _height * 0.1,
                      width: _width * 0.2,
                      margin: const EdgeInsets.only(right: 18),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.05),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                          color: _theme.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    Expanded(
                      child: Text("World Link Communications Pvt. Ltd.",
                          style: _textTheme.titleMedium),
                    ),
                  ],
                ),
                SizedBox(height: _height * 0.03),
                Text(
                    "Provide Username to fetch details and pay respective amount.",
                    style: Theme.of(context).textTheme.labelMedium),
                SizedBox(height: _height * 0.03),
                CustomTextField(
                  hintText: "abcd123",
                ),
                SizedBox(height: _height * 0.05),
                CustomRoundedButtom(
                    title: "Procced",
                    onPressed: () {
                      NavigationService.pushNamed(
                        routeName: Routes.internetPaymentDetail,
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
