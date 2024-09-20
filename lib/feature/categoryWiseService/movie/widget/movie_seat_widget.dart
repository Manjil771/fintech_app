import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class MovieSeatWidget extends StatelessWidget {
  MovieSeatWidget({super.key});

  int selectedRowIndex = 0;
  int selectedTheaterIndex = 0;
  checkSeatStaus(final String seatStatus) {
    if (seatStatus == "available") {
      return Colors.green;
    } else if (seatStatus == "sold") {
      return Colors.red;
    } else if (seatStatus == "reserved") {
      return Colors.grey;
    } else if (seatStatus == "selected") {
      return Colors.blue;
    } else {
      return Colors.grey;
    }
  }

  bool _isLoading = false;

  List selectedSeatList = [];
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      showBackButton: true,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      body: BlocConsumer<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }
          if (state is CommonError) {
            showPopUpDialog(
              context: context,
              message: state.message,
              title: "Error",
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }
        },
        builder: (context, state) {
          if (state is CommonStateSuccess<UtilityResponseData>) {
            final UtilityResponseData res = state.data;
            final List seatRowList = res.findValue(primaryKey: "seatRows");
            // final List threaterList = dates[selectedDateIndex]["theaters"];
            // final List showList = threaterList[selectedTheaterIndex]["shows"];

            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      color: CustomTheme.testAppColor,
                      child: Column(
                        children: [
                          Text(
                            res.findValueString("movieName"),
                            style: _textTheme.titleLarge!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.hp,
                          ),
                          Text(
                            res.findValueString("theaterName") +
                                " || " +
                                res.findValueString("theaterAddress"),
                            style: _textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            res.findValueString("showDate") +
                                " || " +
                                res.findValueString("showTime") +
                                " || " +
                                res.findValueString("duration"),
                            style: _textTheme.titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InteractiveViewer(
                            minScale: 0.5,
                            maxScale: 4,
                            child: Container(
                              width: 600,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: seatRowList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: List.generate(
                                      seatRowList[index]["seats"].length,
                                      (seatIndex) {
                                        final List seatList =
                                            seatRowList[index]["seats"];
                                        if (seatList[seatIndex]["seatId"]
                                                    .toString() !=
                                                "null" ||
                                            seatList[seatIndex]["status"]
                                                    .toString() !=
                                                "null") {
                                          return Column(
                                            children: [
                                              Container(
                                                height: 20.hp,
                                                width: 20.wp,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                child: SvgPicture.asset(
                                                  Assets.movieSeatIcon,
                                                  colorFilter: ColorFilter.mode(
                                                      checkSeatStaus(
                                                          seatList[seatIndex]
                                                                  ["status"]
                                                              .toString()),
                                                      BlendMode.srcIn),
                                                ),
                                              ),
                                              Text(seatList[seatIndex]
                                                      ["seatName"]
                                                  .toString()),
                                            ],
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: Colors.lightBlue.shade200,
                      child: Text(
                        "Screen This Side",
                        textAlign: TextAlign.center,
                        style: _textTheme.titleSmall,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                        seatStatusValue.length,
                        (index) => Column(
                          children: [
                            Container(
                              height: 20.hp,
                              width: 20.wp,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              child: SvgPicture.asset(
                                Assets.movieSeatIcon,
                                colorFilter: ColorFilter.mode(
                                    checkSeatStaus(seatStatusValue[index]
                                        .toString()
                                        .toLowerCase()),
                                    BlendMode.srcIn),
                              ),
                            ),
                            Text(seatStatusValue[index].toString()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (selectedSeatList.isNotEmpty)
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.amberAccent,
                    ),
                  )
              ],
            );
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

  List seatStatusValue = ["Available", "Selected", "Sold", "Reserved"];
}
