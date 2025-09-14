import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/url_launcher.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/feature/appContact/resources/app_contact_repository.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';
import 'package:ismart/feature/more/calculator/calculator_screen.dart';

class BankingWidget extends StatefulWidget {
  const BankingWidget({Key? key}) : super(key: key);

  @override
  State<BankingWidget> createState() => _BankingWidgetState();
}

class _BankingWidgetState extends State<BankingWidget> {
  String _supportContact =
      RepositoryProvider.of<AppContactRepository>(NavigationService.context)
          .contactNumber;
  @override
  void initState() {
    super.initState();
    context.read<AppServiceCubit>().fetchAppService();
  }

  @override
  Widget build(BuildContext context) {
    final contactList = _supportContact.split(",");
    return CommonContainer(
      showDetail: false,
      topbarName: LocaleKeys.banking.tr(),
      showTitleText: false,
      showRoundBotton: false,
      showBackBotton: false,
      body: Column(
        children: [
          Container(
              width: double.infinity,
              // height: _height * 0.7,
              child: Container(
                child: BlocBuilder<AppServiceCubit, CommonState>(
                    builder: (context, state) {
                  if (state
                      is CommonDataFetchSuccess<AppServiceManagementModel>) {
                    final filteredItems = state.data
                        .where((item) =>
                            item.uniqueIdentifier
                                .toString()
                                .toLowerCase()
                                .contains("loan_payment".toLowerCase()) &&
                            item.status.toString().toLowerCase() ==
                                "Active".toLowerCase())
                        .toList();

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredItems.isEmpty ? 7 : itemName.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) => CommonGridViewContainer(
                        onContainerPress: () async {
                          if (index == 5) {
                            {
                              final _textTheme =
                                  Theme.of(NavigationService.context).textTheme;
                              showModalBottomSheet(
                                context: NavigationService.context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.hp),
                                    topRight: Radius.circular(30.hp),
                                  ),
                                ),
                                builder: (context) => Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(24),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 24, bottom: 24),
                                        height: 4,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          color: CustomTheme.lightGray
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                      ),
                                      Text(
                                        "Choose Option".tr(),
                                        style: _textTheme.labelLarge!.copyWith(
                                          color: CustomTheme.darkerBlack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const Divider(
                                        height: 40,
                                      ),
                                      ...List.generate(
                                        contactList.length,
                                        (index) {
                                          return InkWell(
                                            onTap: () {
                                              NavigationService.pop();
                                              UrlLauncher.launchPhone(
                                                context:
                                                    NavigationService.context,
                                                phone: contactList[index],
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15.hp,
                                                vertical: 15.hp,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Call Support",
                                                            style: _textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: CustomTheme
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 6),
                                                          Text(
                                                            contactList[index],
                                                            style: _textTheme
                                                                .bodyLarge!
                                                                .copyWith(
                                                              color: CustomTheme
                                                                  .darkGray,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: CustomTheme
                                                            .primaryColor,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          } else {
                            NavigationService.pushNamed(
                                routeName: onPress[index]);
                          }
                        },
                        margin: const EdgeInsets.all(8),
                        containerImage: images[index],
                        title: itemName[index],
                      ),
                    );
                    // return GridView.builder(
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   itemCount: (filteredItems.isEmpty ? 4 : itemName.length) +
                    //       1, // Add one for static item
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 2,
                    //   ),
                    //   itemBuilder: (context, index) {
                    //     final isStaticItem = index ==
                    //         (filteredItems.isEmpty ? 4 : itemName.length);
                    //     if (isStaticItem) {
                    //       return CommonGridViewContainer(
                    //         onContainerPress: () {
                    //           NavigationService.pushNamed(
                    //             routeName: Routes.recentTransactionScreen,
                    //           );
                    //         },
                    //         margin: const EdgeInsets.all(8),
                    //         containerImage: Assets.historyIcon,
                    //         title: 'History',
                    //       );
                    //     }

                    //     return CommonGridViewContainer(
                    //       onContainerPress: () {
                    //         NavigationService.pushNamed(
                    //             routeName: onPress[index]);
                    //       },
                    //       margin: const EdgeInsets.all(8),
                    //       containerImage: images[index],
                    //       title: itemName[index],
                    //     );
                    //   },
                    // );
                  }
                  if (state is CommonLoading) {
                    return const CommonLoadingWidget();
                  } else {
                    return Container();
                  }
                }),
              )),
        ],
      ),
    );
  }

  final itemName = [
    LocaleKeys.balanceInquiry.tr(),
    LocaleKeys.statement.tr(),
    LocaleKeys.chequeRequest.tr(),
    LocaleKeys.calculator.tr(),
    LocaleKeys.download.tr(),
    LocaleKeys.support.tr(),
    LocaleKeys.feedback.tr(),
    LocaleKeys.loan.tr(),
  ];
  final images = [
    // Assets.accountInfo,
    Assets.balanceInquiry,
    Assets.statement,
    // Assets.sendMoneyRemit,
    Assets.chequeBookIcon,
    Assets.discountCalculator,
    Assets.downloadIcon,
    Assets.contactUsIcon,
    Assets.feedBackIcon,
    Assets.loanIcon,
  ];
  final onPress = [
    // Routes.profileScreen,
    Routes.balanceInquiry,
    Routes.statementPage,
    // Routes.internalCooperative,
    Routes.chequeScreen,
    Routes.calculator,
    Routes.downloadScreen,
    Routes.support,
    Routes.feedback,
    Routes.chooseLoanAccountPage,
  ];
}
