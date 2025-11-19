import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';

class HomePageMoneyWidget extends StatelessWidget {
  const HomePageMoneyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: CustomTheme.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                spreadRadius: 1,
                offset: const Offset(1, 2),
              ),
            ],
            // border: Border.all(color: CustomTheme.primaryColor),
          ),
          // padding: const EdgeInsets.symmetric(
          //   horizontal: 15,
          //   vertical: 15,
          // ),
          child: BlocConsumer<AppServiceCubit, CommonState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state
                    is CommonDataFetchSuccess<AppServiceManagementModel>) {
                  final filteredItems = state.data
                      .where((item) =>
                          (item.type
                              .toString()
                              .toLowerCase()
                              .contains("send".toLowerCase())) &&
                          item.status.toLowerCase() == "Active".toLowerCase())
                      .toList();
                  // final AppServiceManagementModel filteredInstaLoan =
                  //     state.data.firstWhere(
                  //   (item) =>
                  //       (item.type
                  //           .toString()
                  //           .toLowerCase()
                  //           .contains("loan".toLowerCase())) &&
                  //       item.uniqueIdentifier
                  //           .toString()
                  //           .toLowerCase()
                  //           .contains("insta_loan".toLowerCase()),
                  //   orElse: () => throw Exception('No matching item found'),
                  // );
                  print("Total items: ${state.data.length}");
                  print("Filtered items length: ${filteredItems.length}");
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // if (filteredInstaLoan.status.toLowerCase() == "active")
                        //   Container(
                        //     height: 40.hp,
                        //     width: double.infinity,
                        //     decoration: const BoxDecoration(
                        //         color: Colors.red,
                        //         image: DecorationImage(
                        //           image: AssetImage(Assets.instaLoanBanner),
                        //         )),
                        //   ),
                        Row(
                          children: [
                            ...List.generate(
                              filteredItems.length,
                              (index) => InkWell(
                                onTap: () {
                                  print("Onclick action");
                                  if (filteredItems[index]
                                      .uniqueIdentifier
                                      .toString()
                                      .toLowerCase()
                                      .contains(
                                          "bank_transfer".toLowerCase())) {
                                    NavigationService.pushNamed(
                                        routeName: Routes.anyBank);
                                  } else if (filteredItems[index]
                                      .uniqueIdentifier
                                      .toString()
                                      .toLowerCase()
                                      .contains("fund_transfer_dashboard"
                                          .toLowerCase())) {
                                    NavigationService.pushNamed(
                                        routeName: Routes.internalCooperative);
                                  } else if (filteredItems[index]
                                          .uniqueIdentifier
                                          .toString()
                                          .toLowerCase() ==
                                      "coop_transfer".toLowerCase()) {
                                    NavigationService.pushNamed(
                                        routeName: Routes.otherCooperative);
                                  } else if (filteredItems[index]
                                          .uniqueIdentifier
                                          .toString()
                                          .toLowerCase() ==
                                      "load_wallet".toLowerCase()) {
                                    NavigationService.pushNamed(
                                        routeName: Routes.listWalletScreen);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      SvgPicture.network(
                                        "${RepositoryProvider.of<CoOperative>(context).baseUrl}" +
                                            filteredItems[index]
                                                .imageUrl
                                                .toString(),
                                        height: 20.hp,
                                        fit: BoxFit.fitHeight,
                                        color: CustomTheme.primaryColor,
                                      ),
                                      SizedBox(height: 5.hp),
                                      Center(
                                        child: Text(
                                          filteredItems[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                          // .copyWith(
                                          //   fontSize: 12,
                                          //   color: CustomTheme.primaryColor,
                                          // ),
                                          ,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   itemCount: filteredItems.length,
                            //   scrollDirection: Axis.horizontal,
                            //   // shrinkWrap: true,
                            //   itemBuilder: (context, index) {
                            //     return  },
                            // ),

                            InkWell(
                              onTap: () {
                                NavigationService.pushNamed(
                                    routeName: Routes.loadFromKhalti);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      Assets.reveiceMoneyIcon,
                                      height: 20.hp,
                                      color: CustomTheme.primaryColor,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(height: 5.hp),
                                    Text(
                                      "Load Money",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!,
                                      // .copyWith(
                                      //   fontSize: 12,
                                      //   color: CustomTheme.primaryColor,
                                      // ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                  // return Row(
                  //   children: [
                  //     // CustomImageBox(
                  //     //   shadow: false,
                  //     //   backgroundColor: Colors.white,
                  //     //   image: Assets.reveiceMoneyIcon,
                  //     //   isNetworkImage: false,
                  //     //   title: "Load Money",
                  //     // ),
                  //     Expanded(
                  //       child: ListView.builder(
                  //         itemCount: filteredItems.length,
                  //         // scrollDirection: Axis.horizontal,
                  //         // shrinkWrap: true,
                  //         itemBuilder: (context, index) {
                  //           return CustomImageBox(
                  //               image: filteredItems[index].imageUrl.toString());
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // );
                } else {
                  return Container();
                }
              }),
        ),
      ],
    );
  }
}
