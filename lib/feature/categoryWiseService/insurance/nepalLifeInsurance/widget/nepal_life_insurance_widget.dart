import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/primary_account_box.dart';

class NepalLifeInsurcnceWidget extends StatefulWidget {
  final String companyName;
  final String companyLogo;

  NepalLifeInsurcnceWidget(
      {super.key, required this.companyName, required this.companyLogo});

  @override
  State<NepalLifeInsurcnceWidget> createState() =>
      _NepalLifeInsurcnceWidgetState();
}

class _NepalLifeInsurcnceWidgetState extends State<NepalLifeInsurcnceWidget> {
  TextEditingController selectedDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        title: "Insurance Paymenent",
        detail: "Pay for your Insurance premium from here.",
        showDetail: true,
        topbarName: "TV Payment",
        buttonName: "Show Details",
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
                          "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.companyLogo}"),
                    ),
                    Expanded(
                      child: Text(widget.companyName,
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
                CustomTextField(title: "Policy No", hintText: "Policy NO"),
                SizedBox(height: _height * 0.01),
                CustomTextField(
                  onTap: () async {
                    final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1905),
                        lastDate: DateTime.now());
                    setState(
                      () {
                        selectedDateController.text =
                            "${date!.year}-${date.month}-${date.day}";
                      },
                    );
                  },
                  title: "Date of Birth",
                  hintText: "yyyy-mm-dd",
                  readOnly: true,
                  controller: selectedDateController,
                  trailing: SvgPicture.asset(
                    Assets.calanderIcon,
                    height: _height * 0.05,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
