import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';

import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';

import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/buy_datapack_screen.dart';

class SelectDatapackWidget extends StatefulWidget {
  SelectDatapackWidget({Key? key}) : super(key: key);

  @override
  State<SelectDatapackWidget> createState() => _SelectDatapackWidgetState();
}

class _SelectDatapackWidgetState extends State<SelectDatapackWidget> {
  bool viewMore = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        topbarName: 'Payment',
        title: 'Buy Data Packs',
        detail: 'Buy your data packs from here',
        showTitleText: true,
        body: Container(
          height: _height * 0.7,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: CustomTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: CustomTheme.gray,
                              borderRadius: BorderRadius.circular(18)),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            '1 Day - 40 Min-Day Pack',
                            style:
                                _textTheme.displaySmall!.copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          children: [
                            Text(
                              'NPR',
                              style: _textTheme.headlineSmall,
                            ),
                            Text(
                              '1000.00',
                              style: _textTheme.displaySmall!
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                maxLines: viewMore ? 10 : 1,
                                'Get 40 minutes Ncell talktime valid for 1 day',
                                style: _textTheme.titleSmall!.copyWith(
                                  color: CustomTheme.darkGray,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (viewMore == false) {
                                        viewMore = true;
                                      } else {
                                        viewMore = false;
                                      }
                                    });
                                  },
                                  child: Text(
                                    viewMore ? 'View Less' : 'View More',
                                    style: _textTheme.titleSmall!.copyWith(
                                        color: CustomTheme.primaryColor),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomRoundedButtom(
                          verticalPadding: 10,
                          fontSize: 10,
                          title: 'Buy Now',
                          onPressed: () {
                            NavigationService.push(
                                target: const BuyDatapackScreen());
                          },
                          color: CustomTheme.backgroundColor,
                          textColor: CustomTheme.primaryColor,
                          borderColor: CustomTheme.primaryColor,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        showDetail: true,
        showRoundBotton: false,
      ),
    );
  }
}
