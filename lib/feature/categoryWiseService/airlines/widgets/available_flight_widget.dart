import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_error_dialog.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/passenger_detail_page.dart';

class AvailableFlightWidget extends StatefulWidget {
  const AvailableFlightWidget(
      {Key? key, required this.adultCount, required this.childrenCount})
      : super(key: key);
  final adultCount;
  final childrenCount;

  @override
  State<AvailableFlightWidget> createState() => _AvailableFlightWidgetState();
}

class _AvailableFlightWidgetState extends State<AvailableFlightWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: false,
        showTitleText: false,
        showRoundBotton: false,
        topbarName: 'Book Flight',
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Flights',
                  style: _textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(Assets.filterIcon, height: 20),
                )
              ],
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
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
                                borderRadius: BorderRadius.circular(16)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Yeti Air',
                                  style: _textTheme.displaySmall!
                                      .copyWith(fontSize: 16),
                                ),
                                Text(
                                  '8:00 AM - 9:00 PM',
                                  style: _textTheme.displaySmall!
                                      .copyWith(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Text(
                                'Ticket Price',
                                style: _textTheme.headlineSmall,
                              ),
                              Text(
                                '5000',
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Non Refundable',
                                style: _textTheme.titleSmall!.copyWith(
                                  fontSize: 14,
                                  color: CustomTheme.darkGray,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                child: CustomRoundedButtom(
                                    horizontalPadding: 0,
                                    verticalPadding: 5,
                                    color: Colors.transparent,
                                    textColor: CustomTheme.primaryColor,
                                    borderColor: Colors.transparent,
                                    fontSize: 14,
                                    title: 'Fare Summary >',
                                    onPressed: () {
                                      showGeneralDialog(
                                        context: context,
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return WillPopScope(
                                            onWillPop: () =>
                                                Future.value(false),
                                            child: Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 30.hp,
                                                  horizontal: 15.hp,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Fare Summary",
                                                        style: _textTheme
                                                            .displaySmall),
                                                    const SizedBox(height: 14),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color: CustomTheme
                                                                .gray),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Description',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      'Adult Fare',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      'Fuel Charge',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      'Fee & Tax',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        0,
                                                                    vertical:
                                                                        10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Individual Cost',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      '1600',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      '0.0',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      '0.0',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10,
                                                                        top: 10,
                                                                        bottom:
                                                                            10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Total',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      '1600',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      '0.0',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      '0.0',
                                                                      style: _textTheme
                                                                          .titleLarge,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Grand Total',
                                                                  style: _textTheme
                                                                      .headlineSmall,
                                                                ),
                                                                Text(
                                                                  '16000',
                                                                  style: _textTheme
                                                                      .headlineSmall!
                                                                      .copyWith(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                CustomRoundedButtom(
                                                              title: LocaleKeys
                                                                  .done
                                                                  .tr(),
                                                              onPressed: () {
                                                                NavigationService
                                                                    .pop();
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomRoundedButtom(
                            verticalPadding: 10,
                            // horizontalMargin: 40,
                            fontSize: 12,
                            title: 'Book Now',
                            onPressed: () {
                              NavigationService.push(
                                  target: PassengerDetailScreen(
                                adultCount: widget.adultCount,
                                childrenCount: widget.childrenCount,
                              ));
                            },
                            textColor: CustomTheme.white,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
