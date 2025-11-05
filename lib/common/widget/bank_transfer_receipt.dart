import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/file_download_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_avliable_list_model.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/history/cubit/receipt_download_cubit.dart';
import 'package:ismart/feature/history/resources/recent_transaction_repository.dart';

class BankTransferReciptPage extends StatelessWidget {
  final Widget body;
  final String? imageUrl;
  final String message;
  final ServiceList? service;
  final String transactionID;
  final String? pdfUrl;
  final Flight? departure;
  final Flight? arrival;

  const BankTransferReciptPage(
      {super.key,
      required this.body,
      this.imageUrl,
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
      child: BankTransferReciptWidget(
        body: body,
        imageUrl: imageUrl,
        transactionID: transactionID,
        message: message,
        service: service,
      ),
    );
  }
}

class BankTransferReciptWidget extends StatelessWidget {
  final Widget body;
  final String? imageUrl;
  final String message;
  final String transactionID;

  final ServiceList? service;
  const BankTransferReciptWidget({
    super.key,
    required this.body,
    this.imageUrl,
    required this.message,
    required this.service,
    required this.transactionID,
  });

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;

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
                    Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // SvgPicture.asset(
                            //   Assets.successIcon,
                            //   height: _height * 0.08,
                            // ),
                            CustomCachedNetworkImage(
                              url: RepositoryProvider.of<CoOperative>(context)
                                  .coOperativeLogo
                                  .toString(),
                              fit: BoxFit.fitHeight,
                              height: _height * 0.08,
                            ),
                            // SizedBox(height: _height * 0.02),
                            // const Text(
                            //   "Transaction Successful",
                            //   style: TextStyle(
                            //       fontSize: 20,
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.w500),
                            // ),
                            // SizedBox(height: _height * 0.02),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Flexible(
                            //       child: Text(message,
                            //           textAlign: TextAlign.center,
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .titleSmall),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: _height * 0.02),
                          ],
                        ),
                        if (imageUrl != null)
                          Positioned(
                            bottom: 0,
                            right: 0.wp,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.wp,
                                  vertical: 4.hp,
                                ),
                                child: CustomCachedNetworkImage(
                                  url: imageUrl ?? '',
                                  fit: BoxFit.contain,
                                  height: 30.hp,
                                  width: 30.wp,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: _height * 0.02),
                    Text(
                      LocaleKeys.transactionSuccessful.tr(),
                      style: const TextStyle(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Payment Details",
                              style: Theme.of(context).textTheme.titleLarge),
                          SizedBox(height: _height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: KeyValueTile(
                                    bottomPadding: 0,
                                    title: "Transaction ID",
                                    value: transactionID),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.copy,
                                  size: 18.hp,
                                ),
                                tooltip: 'Copy Transaction ID',
                                onPressed: () async {
                                  await Clipboard.setData(
                                      ClipboardData(text: transactionID));
                                  SnackBarUtils.showSuccessBar(
                                      context: context,
                                      message: "Transaction ID copied!");
                                },
                              )
                            ],
                          ),
                          body,
                        ],
                      ),
                    ),
                    SizedBox(height: _height * 0.02),
                    CustomRoundedButtom(
                        title: LocaleKeys.done.tr(),
                        onPressed: () {
                          NavigationService.pushReplacementNamed(
                              routeName: Routes.dashboard);
                          // NavigationService.pushReplacement(
                          //     target: const DashboardPage());
                        }),
                    SizedBox(height: _height * 0.02),
                    BlocConsumer<TransactionDownloadCubit, CommonState>(
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
                                fileName:
                                    FileDownloadUtils.generateDownloadFileName(
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
