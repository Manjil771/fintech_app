import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';

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
    final _height = SizeUtils.height;
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
            final filteredItems = state.data
                .where((item) =>
                    item.type
                        .toString()
                        .toLowerCase()
                        .contains("receive".toLowerCase()) &&
                    item.status.toLowerCase() == "Active".toLowerCase())
                .toList();

            return CommonContainer(
                horizontalPadding: 0,
                showDetail: false,
                showBackBotton: true,
                showRoundBotton: false,
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: _height * 0.56,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              checkItems(filteredItems[index].uniqueIdentifier);
                              return Column(
                                children: [
                                  CommonDetailBox(
                                    isNetworkImage: true,
                                    title: filteredItems[index].name,
                                    leadingIcon:
                                        "${RepositoryProvider.of<CoOperative>(context).baseUrl}${filteredItems[index].imageUrl}",
                                    onBoxPressed: () {
                                      // checkNivigation(filteredItems[index].name);
                                      if (filteredItems[index]
                                          .uniqueIdentifier
                                          .toString()
                                          .toLowerCase()
                                          .contains(
                                              "load_fund".toLowerCase())) {
                                        NavigationService.pushNamed(
                                            routeName: Routes.mobileBanking);
                                      }
                                      if (filteredItems[index]
                                          .uniqueIdentifier
                                          .toString()
                                          .toLowerCase()
                                          .contains("load_from_connectIps"
                                              .toLowerCase())) {
                                        NavigationService.pushNamed(
                                            routeName: Routes.connectIps);
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
                                  Divider(thickness: 1)
                                ],
                              );
                            },
                          ),
                        ),
                        state.data[0].status.toString().toLowerCase() ==
                                "Active".toLowerCase()
                            ? Container(
                                height: _height * 0.22,
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    CommonDetailBox(
                                      onBoxPressed: () {
                                        NavigationService.pushNamed(
                                            routeName: Routes.internetbanking);
                                      },
                                      title: "Internet Banking",
                                      detail:
                                          "Make financial transactions through internet using your preferred devices.",
                                      leadingIcon: Assets.bankTransfer,
                                    ),
                                    const Divider(thickness: 1),
                                    CommonDetailBox(
                                      onBoxPressed: () {
                                        NavigationService.pushNamed(
                                            routeName: Routes.loadViaCard);
                                      },
                                      title: "Load via Card",
                                      detail:
                                          "Load fund instantly from the card.",
                                      leadingIcon: Assets.cardIcon,
                                    ),
                                    const Divider(thickness: 1),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
                showTitleText: false,
                topbarName: "Receive Money");
          } else {
            return Container();
          }
        },
      ),
    );
  }

  checkDesc(uniqueIdentifier) {
    if (uniqueIdentifier
        .toString()
        .toLowerCase()
        .contains("load_fund".toLowerCase())) {
      return "Make financial transactions using your phone";
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
        .contains("Remittance".toLowerCase())) {
      return "Send or Receive money from foreign land";
    } else {
      return "";
    }
  }
}







// import 'package:flutter/material.dart';
// import 'package:ismart/common/constant/assets.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/route/routes.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/common_detail_box.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';

// class ReceiveMoneyWidget extends StatelessWidget {
//   const ReceiveMoneyWidget({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return PageWrapper(
//       body: CommonContainer(
//           showDetail: true,
//           showTitleText: false,
//           horizontalPadding: 0,
//           body: Column(
//             children: [
//               CommonDetailBox(
//                 onBoxPressed: () {
//                   NavigationService.pushNamed(routeName: Routes.mobileBanking);
//                 },
//                 title: "Mobile Banking",
//                 detail: "Make financial transactions using your phone",
//                 leadingIcon: Assets.mobileBanking,
//               ),
//               const Divider(thickness: 1),
//               CommonDetailBox(
//                 onBoxPressed: () {
//                   NavigationService.pushNamed(
//                       routeName: Routes.internetbanking);
//                 },
//                 title: "Internet Banking",
//                 detail:
//                     "Make financial transactions through internet using your preferred devices.",
//                 leadingIcon: Assets.bankTransfer,
//               ),
//               const Divider(thickness: 1),
//               CommonDetailBox(
//                 onBoxPressed: () {
//                   NavigationService.pushNamed(routeName: Routes.loadViaCard);
//                 },
//                 title: "Load via Card",
//                 detail: "Load fund instantly from the card.",
//                 leadingIcon: Assets.cardIcon,
//               ),
//               const Divider(thickness: 1),
//               CommonDetailBox(
//                 onBoxPressed: () {
//                   NavigationService.pushNamed(routeName: Routes.connectIps);
//                 },
//                 title: "Connect IPS",
//                 detail: "Send Money using Connect IPS.",
//                 leadingIcon: Assets.connectIpsIcon,
//               ),
//               const Divider(thickness: 1),
//               CommonDetailBox(
//                 onBoxPressed: () {
//                   NavigationService.pushNamed(routeName: Routes.requestSapati);
//                 },
//                 title: "Request Sapati",
//                 detail: "Lend money from your friends using app",
//                 leadingIcon: Assets.sapatiIcon,
//               ),
//               const Divider(thickness: 1),
//               CommonDetailBox(
//                 onBoxPressed: () {},
//                 title: "Remittance",
//                 detail: "Send Money using Connect IPS.",
//                 leadingIcon: Assets.remittanceIcon,
//               )
//             ],
//           ),
//           showRoundBotton: false,
//           topbarName: "Receive Money"),
//     );
//   }
// }
