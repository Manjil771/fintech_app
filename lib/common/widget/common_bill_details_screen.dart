import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';

class CommonBillDetailPage extends StatelessWidget {
  final String image;
  final String serviceType;
  final Widget body;
  final Function()? onButtonPress;
  const CommonBillDetailPage(
      {super.key,
      required this.image,
      required this.body,
      required this.serviceType,
      this.onButtonPress});

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: CustomTheme.white,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  image,
                  height: _height * 0.08,
                ),
                SizedBox(height: _height * 0.02),
                Text(
                  serviceType,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: _height * 0.02),
                Text(
                    "Details about the payable amount for the service of $serviceType is shown below.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: _height * 0.02),
                const Divider(thickness: 1),
                SizedBox(height: _height * 0.02),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFF3F3F3),
                    // border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Paymet Details",
                          style: Theme.of(context).textTheme.titleLarge),
                      SizedBox(height: _height * 0.02),
                      body,
                    ],
                  ),
                ),
                SizedBox(height: _height * 0.02),
                CustomRoundedButtom(title: "Pay", onPressed: onButtonPress),
                // Container(
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(18),
                //       border:
                //           Border.all(color: Theme.of(context).primaryColor)),
                //   child: CustomRoundedButtom(
                //       textColor: Theme.of(context).primaryColor,
                //       title: "Download Receipt",
                //       color: Colors.transparent,
                //       onPressed: () {}),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
