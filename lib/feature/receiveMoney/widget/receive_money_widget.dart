import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/receive_remittance_page.dart';

class ReceiveMoneyWidget extends StatefulWidget {
  const ReceiveMoneyWidget({Key? key}) : super(key: key);

  @override
  State<ReceiveMoneyWidget> createState() => _ReceiveMoneyWidgetState();
}

class _ReceiveMoneyWidgetState extends State<ReceiveMoneyWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AppServiceCubit>().fetchAppService();
  }

  checkItems(uniqueIdentifier) {
    if (uniqueIdentifier.toString().toLowerCase() ==
        "load_fund".toLowerCase()) {
      showData = true;
    }
  }

  bool showData = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: BlocConsumer<AppServiceCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && !_isLoading) {
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
          if (state is CommonDataFetchSuccess<AppServiceManagementModel>) {
            final filteredMobileBanking = state.data
                .where(
                  (item) =>
                      item.uniqueIdentifier
                          .toString()
                          .toLowerCase()
                          .contains("load_fund".toLowerCase()) &&
                      item.status.toString().toLowerCase() ==
                          "Active".toLowerCase(),
                )
                .toList();
            // final filteredItems = state.data;

            final filteredItems = state.data
                .where((item) =>
                    item.type
                        .toString()
                        .toLowerCase()
                        .contains("receive".toLowerCase()) &&
                    item.status.toLowerCase() == "Active".toLowerCase())
                .toList();

            return CommonContainer(
                verticalPadding: 0,
                horizontalPadding: 0,
                showDetail: false,
                showBackBotton: true,
                showRoundBotton: false,
                body: Column(
                  children: [
                    Container(
                      child: filteredMobileBanking.isNotEmpty
                          ? Column(
                              children: [
                                CommonDetailBox(
                                  onBoxPressed: () {
                                    NavigationService.pushNamed(
                                        routeName: Routes.internetbanking);
                                  },
                                  title: "Internet Banking",
                                  detail:
                                      "Make financial transactions through internet using your preferred devices.",
                                  leadingImage: Assets.bankTransfer,
                                ),
                                const Divider(thickness: 1),
                              ],
                            )
                          : const NoDataScreen(
                              title: "Services unavailable now.",
                              details:
                                  'Currently all our services seem to be under maintenance. We will update you as soon as our services get back to operation.',
                            ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItems.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        checkItems(filteredItems[index].uniqueIdentifier);
                        return Column(
                          children: [
                            CommonDetailBox(
                              isNetworkImage: true,
                              title: filteredItems[index].name,
                              leadingImage:
                                  "${RepositoryProvider.of<CoOperative>(context).baseUrl}${filteredItems[index].imageUrl}",
                              onBoxPressed: () {
                                // checkNivigation(filteredItems[index].name);
                                if (filteredItems[index]
                                    .uniqueIdentifier
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        "load_fund_khalti".toLowerCase())) {
                                  NavigationService.pushNamed(
                                      routeName: Routes.loadFromKhalti);
                                } else if (filteredItems[index]
                                    .uniqueIdentifier
                                    .toString()
                                    .toLowerCase()
                                    .contains("load_fund".toLowerCase())) {
                                  NavigationService.pushNamed(
                                      routeName: Routes.mobileBanking);
                                }
                                if (filteredItems[index]
                                    .uniqueIdentifier
                                    .toString()
                                    .toLowerCase()
                                    .contains(
                                        "load_from_connectIps".toLowerCase())) {
                                  NavigationService.pushNamed(
                                      routeName: Routes.connectIps);
                                } else if (filteredItems[index]
                                        .uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    "remittance".toLowerCase()) {
                                  // NavigationService.push(
                                  //     target: const ReceiveRemittancePage());
                                } else if (filteredItems[index]
                                        .uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    "request_sapati".toLowerCase()) {
                                  NavigationService.pushNamed(
                                      routeName: Routes.requestSapati);
                                } else if (filteredItems[index]
                                        .uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    "load_wallet".toLowerCase()) {
                                  NavigationService.pushNamed(
                                      routeName: Routes.listWalletScreen);
                                }
                                // else {
                                //   NavigationService.pushNamed(
                                //       routeName: Routes.mobileTopup);
                                // }
                              },
                              detail: checkDesc(
                                  filteredItems[index].uniqueIdentifier),
                            ),
                            const Divider(thickness: 1)
                          ],
                        );
                      },
                    ),
                  ],
                ),
                showTitleText: false,
                topbarName: "Receive Money");
          }

          return Container();
          // else {
          //   return const NoDataScreen(
          //     title: "Services unavailable now.",
          //     details:
          //         'Currently all our services seem to be under maintenance. We will update you as soon as our services get back to operation.',
          //   );
          // }
        },
      ),
    );
  }

  checkDesc(uniqueIdentifier) {
    if (uniqueIdentifier
        .toString()
        .toLowerCase()
        .contains("load_fund_khalti".toLowerCase())) {
      return "Load Money from Ebanking, Mobile Banking, Khalti and more.";
    } else if (uniqueIdentifier
        .toString()
        .toLowerCase()
        .contains("load_from_connectIps".toLowerCase())) {
      return "Send Money using Connect IPS.";
    } else if (uniqueIdentifier
        .toString()
        .toLowerCase()
        .contains("request_sapati".toLowerCase())) {
      return "Lend money from your friends using app";
    } else if (uniqueIdentifier
        .toString()
        .toLowerCase()
        .contains("load_fund".toLowerCase())) {
      return "Make financial transactions using your phone";
    } else if (uniqueIdentifier
        .toString()
        .toLowerCase()
        .contains("Remittance".toLowerCase())) {
      return "Send or Receive money from foreign land";
    } else {
      return "";
    }
  }
}
