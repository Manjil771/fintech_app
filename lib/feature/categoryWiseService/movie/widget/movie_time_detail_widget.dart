import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/movie/screen/movie_seat_page.dart';
import 'package:ismart/feature/categoryWiseService/movie/widget/animated_date_selector.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class MovieTimeDetailWidget extends StatefulWidget {
  const MovieTimeDetailWidget({super.key});

  @override
  State<MovieTimeDetailWidget> createState() => _MovieTimeDetailWidgetState();
}

class _MovieTimeDetailWidgetState extends State<MovieTimeDetailWidget> {
  int selectedDateIndex = 0;
  int selectedTheaterIndex = 0;

  void _handleDateSelected(int index) {
    setState(() {
      selectedDateIndex = index;
    });
  }

  List<DateSelectorItem> _prepareDateItems(List dates) {
    return dates.map((dateData) {
      return DateSelectorItem(
        date: dateData["showDate"],
        displayText: formatShowDate(dateData["showDate"]),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return PageWrapper(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      showBackButton: true,
      body: BlocBuilder<UtilityPaymentCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonStateSuccess<UtilityResponseData>) {
            final UtilityResponseData res = state.data;

            if (res.findValueString("code") == "000") {
              final List dates = res.findValue(primaryKey: "dates");
              final List threaterList = dates[selectedDateIndex]["theaters"];
              final List showList = threaterList[selectedTheaterIndex]["shows"];

              return Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: CustomCachedNetworkImage(
                                url: res.findValue(primaryKey: "poster"),
                                fit: BoxFit.cover,
                                height: 17.h,
                                width: 13.h,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    capitalizeEachWord(
                                        res.findValue(primaryKey: "movieName")),
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: .8.h),
                                  Text(
                                    res.findValue(primaryKey: "genre"),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: .8.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 15,
                                        color: Colors.grey[600],
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        res.findValue(primaryKey: "duration"),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (dates.isNotEmpty)
                    AnimatedDateSelector(
                      dates: _prepareDateItems(dates),
                      onDateSelected: _handleDateSelected,
                      initialSelectedIndex: selectedDateIndex,
                      indicatorColor: CustomTheme.testAppColor,
                      selectedTextColor: CustomTheme.testAppColor,
                      unselectedTextColor: Colors.grey[600]!,
                      textStyle: _textTheme.displaySmall,
                    ),
                  if (threaterList.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                          itemCount: threaterList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 0),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black38,
                                    width: 1.0,
                                  ),
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Column(
                                      children: [
                                        Text(
                                          threaterList[index]["theaterName"],
                                          style: _textTheme.headlineSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          threaterList[index]["theaterAddress"],
                                          style: _textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (showList.isNotEmpty)
                                    GridView.builder(
                                      itemCount: showList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                      ),
                                      itemBuilder: (context, showListindex) {
                                        return InkWell(
                                          onTap: () {
                                            NavigationService.push(
                                                target: MovieSeatPage(
                                              showId: showList[showListindex]
                                                  ["showId"],
                                              processId: res.findValue(
                                                  primaryKey: "processId"),
                                              movieId: res.findValue(
                                                  primaryKey: "movieId"),
                                            ));
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                                color: CustomTheme.testAppColor,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.fromLTRB(
                                                12, 10, 0, 12),
                                            child: Text(
                                              "${showList[showListindex]["screenName"]}\n${showList[showListindex]["showTime"]}",
                                              textAlign: TextAlign.center,
                                              style: _textTheme.titleSmall!
                                                  .copyWith(
                                                      color: CustomTheme.white),
                                              maxLines: 3,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                ],
                              ),
                            );
                          }),
                    ),
                  SizedBox(
                    height: 10.hp,
                  )
                ],
              );
            } else {
              return Scaffold(
                  body: NoDataScreen(
                      title: "No Data Found",
                      details: res.findValueString("message")));
            }
          } else if (state is CommonError) {
            return NoDataScreen(title: "Error", details: state.message);
          } else if (state is CommonLoading) {
            return const CommonLoadingWidget();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  String formatShowDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    final String dayNum = date.day.toString();
    final String dayName = DateFormat('EEEE').format(date);

    if (date.year == today.year &&
        date.month == today.month &&
        date.day == today.day) {
      return '$dayNum\nToday';
    } else if (date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day) {
      return '$dayNum\nTomorrow';
    }

    return '$dayNum\n$dayName';
  }

  String capitalizeEachWord(String title) {
    return title.split(' ').map((word) {
      return word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '';
    }).join(' ');
  }
}
