import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/movie/resource/model/movie_seat_model.dart';
import 'package:ismart/feature/categoryWiseService/movie/resource/model/movie_seat_select_model.dart';
import 'package:ismart/feature/categoryWiseService/movie/resource/movie_cubit.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class MovieSeatWidget extends StatefulWidget {
  const MovieSeatWidget({super.key});

  @override
  State<MovieSeatWidget> createState() => _MovieSeatWidgetState();
}

class _MovieSeatWidgetState extends State<MovieSeatWidget> {
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
  String currentSeatId = "";
  List<String> selectedSeatList = [];

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      showBackButton: true,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      body: BlocBuilder<MovieCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonStateSuccess<MovieSeatModel>) {
            final MovieSeatModel res = state.data;
            final List<SeatRows> seatRowList = res.details?.seatRows ?? [];
            return Column(
              children: [
                Text(selectedSeatList.toString() + " test"),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: CustomTheme.testAppColor,
                  child: Column(
                    children: [
                      Text(
                        res.details?.movieName ?? "",
                        style: _textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10.hp,
                      ),
                      Text(
                        res.details!.theaterName.toString() +
                            " || " +
                            res.details!.theaterAddress.toString(),
                        style: _textTheme.titleSmall!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        res.details!.showDate.toString() +
                            " || " +
                            res.details!.showTime.toString() +
                            " || " +
                            res.details!.duration.toString(),
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
                                  seatRowList[index].seats?.length ?? 0,
                                  (seatIndex) {
                                    final List<Seats> seatList =
                                        seatRowList[index].seats ?? [];
                                    if (seatList[seatIndex].seatId.toString() !=
                                            "null" ||
                                        seatList[seatIndex].status.toString() !=
                                            "null") {
                                      return BlocListener<MovieCubit,
                                          CommonState>(
                                        listener: (context, state) {
                                          if (state is CommonLoading &&
                                              _isLoading == false) {
                                            _isLoading = true;
                                            // showLoadingDialogBox(context);
                                          } else if (state is! CommonLoading &&
                                              _isLoading) {
                                            _isLoading = false;
                                            NavigationService.pop();
                                          } else if (state
                                              is CommonStateSuccess<
                                                  MovieSeatSelectModel>) {
                                            final MovieSeatSelectModel res =
                                                state.data;
                                            if (res.code == "M0000") {
                                              if (selectedSeatList.contains(
                                                  seatList[seatIndex].seatId)) {
                                                setState(() {
                                                  selectedSeatList.remove(
                                                      seatList[seatIndex]
                                                          .seatId);
                                                });
                                              } else {
                                                setState(() {
                                                  selectedSeatList.add(
                                                      seatList[seatIndex]
                                                              .seatId ??
                                                          "null");
                                                });
                                              }
                                              SnackBarUtils.showSuccessBar(
                                                  context: context,
                                                  message: res.message ?? "");
                                            } else {
                                              SnackBarUtils.showErrorBar(
                                                  context: context,
                                                  message: res.message ?? "");
                                            }
                                          } else if (state is CommonError) {
                                            SnackBarUtils.showErrorBar(
                                                context: context,
                                                message: res.message ?? "");
                                          }
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            context
                                                .read<MovieCubit>()
                                                .selectSeat(
                                                    serviceIdentifier: "",
                                                    accountDetails: {
                                                      "processId": res.details
                                                              ?.processId ??
                                                          " ",
                                                      "movieId": res.details
                                                              ?.movieId ??
                                                          "",
                                                      "seatId":
                                                          seatList[seatIndex]
                                                              .seatId,
                                                      "seatCategory": res
                                                          .details!
                                                          .seatRows![index]
                                                          .category
                                                          .toString(),
                                                      "showId": res
                                                          .details?.showId
                                                          .toString(),
                                                    },
                                                    body: {},
                                                    apiEndpoint: selectedSeatList
                                                            .contains(seatList[
                                                                    seatIndex]
                                                                .seatId)
                                                        ? "/api/movie/seat/unselect"
                                                        : "/api/movie/seat/select",
                                                    mPin: "");

                                            if (selectedSeatList.contains(
                                                seatList[seatIndex].seatId)) {
                                              setState(() {
                                                selectedSeatList.remove(
                                                    seatList[seatIndex].seatId);
                                              });
                                            } else {
                                              setState(() {
                                                selectedSeatList.add(
                                                    seatList[seatIndex]
                                                            .seatId ??
                                                        "null");
                                              });
                                            }
                                          },
                                          child: Column(
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
                                                      selectedSeatList.contains(
                                                              seatList[
                                                                      seatIndex]
                                                                  .seatId)
                                                          ? checkSeatStaus(
                                                              "selected")
                                                          : checkSeatStaus(
                                                              seatList[
                                                                      seatIndex]
                                                                  .status
                                                                  .toString()),
                                                      BlendMode.srcIn),
                                                ),
                                              ),
                                              Text(seatList[seatIndex]
                                                  .seatName
                                                  .toString()),
                                            ],
                                          ),
                                        ),
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
                    (index) => BlocProvider(
                      create: (context) => UtilityPaymentCubit(
                          utilityPaymentRepository:
                              RepositoryProvider.of<UtilityPaymentRepository>(
                                  context)),
                      child: BlocListener<UtilityPaymentCubit, CommonState>(
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
                          if (state
                              is CommonStateSuccess<MovieSeatSelectModel>) {
                            final res = state.data;
                            if (res.code == "M0000") {
                              SnackBarUtils.showSuccessBar(
                                  context: context, message: res.message ?? "");
                              selectedSeatList.add(currentSeatId);

                              currentSeatId = "";
                            }
                          }
                          if (state
                              is CommonStateSuccess<MovieSeatUnSelectModel>) {
                            final res = state.data;
                            if (res.code == "M0000") {
                              SnackBarUtils.showSuccessBar(
                                  context: context, message: res.message ?? "");
                              selectedSeatList.remove(currentSeatId);
                            }
                          }
                        },
                        child: InkWell(
                          child: Column(
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
                    ),
                  ),
                ),
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
