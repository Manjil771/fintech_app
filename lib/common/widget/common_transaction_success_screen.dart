import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';

class CommonTransactionSuccessPage extends StatelessWidget {
  final Widget body;
  final String message;
  final Service? service;
  final String transactionID;

  const CommonTransactionSuccessPage(
      {super.key,
      required this.body,
      required this.message,
      this.service,
      required this.transactionID});

  @override
  Widget build(BuildContext context) {
    return CommonTransactionSuccessfulPage(
      body: body,
      transactionID: transactionID,
      message: message,
      service: service,
    );
  }
}

class CommonTransactionSuccessfulPage extends StatelessWidget {
  final Widget body;
  final String message;
  final String transactionID;
  //need to inplement pdf download
  final Service? service;
  const CommonTransactionSuccessfulPage(
      {super.key,
      required this.body,
      required this.message,
      required this.service,
      required this.transactionID});

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return PageWrapper(
      showAppBar: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
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
                    Text(message,
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
                        children: [
                          Text("Paymet Details",
                              style: Theme.of(context).textTheme.titleLarge),
                          KeyValueTile(
                              title: "Transaction ID", value: transactionID),
                          body,
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
                    CustomRoundedButtom(
                        borderColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColor,
                        title: "Download Receipt",
                        color: Colors.transparent,
                        onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
