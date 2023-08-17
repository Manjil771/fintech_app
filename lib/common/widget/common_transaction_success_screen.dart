import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/file_download_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/categoryWiseService/airlines/widgets/flight_detail_box.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/history/cubit/receipt_download_cubit.dart';
import 'package:ismart/feature/history/resources/recent_transaction_repository.dart';

class CommonTransactionSuccessPage extends StatelessWidget {
  final Widget body;
  final String message;
  final ServiceList? service;
  final String transactionID;
  final String? pdfUrl;
  final Availability? departure;
  final Availability? arrival;

  const CommonTransactionSuccessPage(
      {super.key,
      required this.body,
      required this.message,
      this.service,
      required this.transactionID,
      this.pdfUrl,
      this.departure,
      this.arrival});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionDownloadCubit(
          recentTransactionRepository:
              RepositoryProvider.of<RecentTransactionRepository>(context))
        ..generateUrl(transactionId: transactionID),
      child: CommonTransactionSuccessfulWidget(
        body: body,
        arrival: arrival,
        departure: departure,
        transactionID: transactionID,
        message: message,
        service: service,
      ),
    );
  }
}

class CommonTransactionSuccessfulWidget extends StatelessWidget {
  final Widget body;
  final String message;
  final String transactionID;
  final String? pdfUrl;
  final Availability? departure;
  final Availability? arrival;

  final ServiceList? service;
  const CommonTransactionSuccessfulWidget(
      {super.key,
      required this.body,
      required this.message,
      required this.service,
      required this.transactionID,
      this.pdfUrl,
      this.departure,
      this.arrival});

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;

    return PageWrapper(
      showAppBar: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: CustomTheme.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(18),
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
                    (service?.uniqueIdentifier ?? "") == "ARS"
                        ? Column(
                            children: [
                              Text(
                                "Departure Flight Details",
                                style: _textTheme.titleSmall!
                                    .copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 5.hp),
                              FlightDetailBox(
                                flight: departure,
                              ),
                              SizedBox(height: 10.hp),
                              if (arrival != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Return Flight Details",
                                      style: _textTheme.titleSmall!.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: 5.hp),
                                    FlightDetailBox(
                                      flight: arrival,
                                    )
                                  ],
                                ),
                            ],
                          )
                        : Container(
                            padding: const EdgeInsets.all(12),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF3F3F3),
                              // border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Paymet Details",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                SizedBox(height: _height * 0.01),
                                KeyValueTile(
                                    title: "Transaction ID",
                                    value: transactionID),
                                body,
                              ],
                            ),
                          ),
                    SizedBox(height: _height * 0.02),
                    CustomRoundedButtom(
                        title: "Done",
                        onPressed: () {
                          NavigationService.pushReplacement(
                              target: const DashboardPage());
                        }),
                    SizedBox(height: _height * 0.02),
                    pdfUrl == null
                        ? BlocConsumer<TransactionDownloadCubit, CommonState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is CommonStateSuccess<String>) {
                                return CustomRoundedButtom(
                                  borderColor: Theme.of(context).primaryColor,
                                  textColor: Theme.of(context).primaryColor,
                                  title: "Download Receipt",
                                  color: Colors.transparent,
                                  onPressed: () {
                                    FileDownloadUtils.downloadFile(
                                      downloadLink: state.data,
                                      fileName: FileDownloadUtils
                                          .generateDownloadFileName(
                                        name: service?.serviceCategoryName ??
                                            "Utility_Payment",
                                        filetype: FileType.pdf,
                                      ),
                                      context: context,
                                    );
                                  },
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        : CustomRoundedButtom(
                            borderColor: Theme.of(context).primaryColor,
                            textColor: Theme.of(context).primaryColor,
                            title: "Download Receipt",
                            color: Colors.transparent,
                            onPressed: () {
                              print(pdfUrl.toString());
                              FileDownloadUtils.downloadFile(
                                downloadLink: pdfUrl.toString(),
                                fileName:
                                    FileDownloadUtils.generateDownloadFileName(
                                  name: service?.serviceCategoryName ??
                                      "Utility_Payment",
                                  filetype: FileType.pdf,
                                ),
                                context: context,
                              );
                            },
                          ),
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
