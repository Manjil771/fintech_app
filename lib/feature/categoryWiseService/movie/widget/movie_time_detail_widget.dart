import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/movie/screen/movie_seat_page.dart';
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
                      CustomCachedNetworkImage(
                        url: res.findValue(primaryKey: "banner"),
                        fit: BoxFit.cover,
                        height: 25.h,
                        width: double.infinity,
                      ),
                      const CircleAvatar(
                        radius: 10,
                        child: Center(
                          child: Icon(
                            Icons.info_outline,
                            color: CustomTheme.testAppColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (dates.isNotEmpty)
                    Container(
                      height: 60.hp,
                      child: ListView.builder(
                          itemCount: dates.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedDateIndex = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: selectedDateIndex == index
                                            ? CustomTheme.testAppColor
                                            : Colors.white),
                                    child: Text(
                                      dates[index]["showDate"],
                                      style: _textTheme.displaySmall!.copyWith(
                                          color: selectedDateIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  if (threaterList.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                          itemCount: threaterList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 1),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
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
                                              crossAxisCount: 4),
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
                                            padding: const EdgeInsets.all(12),
                                            margin: const EdgeInsets.all(12),
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
}
