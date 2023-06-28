import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../../dashboard/screen/dashboard_page.dart';

class InsuranceBillDetailWidget extends StatelessWidget {
  final UtilityResponseData detailFetchData;

  const InsuranceBillDetailWidget({Key? key, required this.detailFetchData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      showAppBar: false,
      body: SafeArea(
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
                  SvgPicture.asset(
                    Assets.successIcon,
                    height: _height * 0.08,
                  ),
                  SizedBox(height: _height * 0.02),
                  const Text(
                    "Transaction Successful",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: _height * 0.02),
                  Text(
                      "Dear Pawan, your payment of NPR 40000 with charge 10 from "
                      "A/C 165###09887 for 9800000000 was sucessful",
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
                        KeyValueTile(
                            title: "Date/Time", value: "30 Mar 2023, 06:56 PM"),
                        KeyValueTile(title: "Channel", value: "Online"),
                        KeyValueTile(
                            title: "Payment Attribute",
                            value: "9800000000/XXXX Payment"),
                        KeyValueTile(title: "Service Name", value: "XXXXX"),
                        KeyValueTile(title: "Amount", value: "10005.00"),
                        KeyValueTile(title: "Initiator", value: "Initiator")
                      ],
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  CustomRoundedButtom(
                      title: "Home",
                      onPressed: () {
                        NavigationService.push(target: DashboardPage());
                      }),
                  SizedBox(height: _height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: CustomRoundedButtom(
                        textColor: Theme.of(context).primaryColor,
                        title: "Download Receipt",
                        color: Colors.transparent,
                        onPressed: () {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
