import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/primary_account_box.dart';

class TvPaymentWidget extends StatelessWidget {
  final String companyName;
  final String companyLogo;

  TvPaymentWidget(
      {super.key, required this.companyName, required this.companyLogo});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        title: "TV Paymenent",
        detail: "Pay for your Tv bill from here.",
        showDetail: true,
        topbarName: "TV Payment",
        buttonName: "Pay",
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      height: _height * 0.11,
                      width: _width * 0.23,
                      margin: const EdgeInsets.only(right: 18),
                      child: Image.network(
                          "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${companyLogo}"),
                    ),
                    Expanded(
                      child: Text(companyName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                Text(
                  "From Account",
                  style: const TextStyle(
                    fontFamily: Fonts.poppin,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: CustomTheme.lightTextColor,
                  ),
                ),
                PrimaryAccountBox(),
                CustomTextField(
                    title: "Chip ID/ Account No/ CAS ID",
                    hintText: "Select your Account"),
                SizedBox(height: _height * 0.01),
                CustomTextField(title: "Amount", hintText: "Enter the amount"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
