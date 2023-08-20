import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/slugs.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/Topup/ui/screens/mobile_topup_page.dart';
import 'package:ismart/feature/categoryWiseService/airlines/screen/airline_page.dart';
import 'package:ismart/feature/categoryWiseService/broker/screen/broker_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/screen/credit_card_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_payment_page.dart';
import 'package:ismart/feature/categoryWiseService/landline/screen/landline_payment_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/category_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/category_wise_services_page.dart';

class CategoryWidget extends StatefulWidget {
  final bool showAllService;
  const CategoryWidget({Key? key, this.showAllService = true})
      : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCategory();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
          color: CustomTheme.white, borderRadius: BorderRadius.circular(18)),
      child: BlocConsumer<CategoryCubit, CommonState>(
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
          if (state is CommonStateSuccess<List<CategoryList>>) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                      child: GridView.builder(
                          itemCount: widget.showAllService
                              ? state.data.length
                              : state.data.length >= 12
                                  ? 12
                                  : state.data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (context, index) {
                            final data = state.data[index];

                            final filteredItems = data.services
                                .where((item) => item.cashBackView != null)
                                .toList();

                            final _imageUrl =
                                "${RepositoryProvider.of<CoOperative>(context).baseUrl}${data.imageUrl}";
                            return InkWell(
                              onTap: () {
                                if (data.uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    Slugs.topup) {
                                  NavigationService.push(
                                      target:
                                          MobileTopupPage(categoryList: data));
                                  return;
                                }
                                if (data.uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    Slugs.brokerPage) {
                                  NavigationService.push(
                                      target: BrokerPaymentPage(
                                          service: data.services.first));
                                } else if (data.uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    "electricity") {
                                  NavigationService.push(
                                      target: ElectricityPaymentPage(
                                    service: data.services[0],
                                  ));
                                } else if (data.uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    "airlines") {
                                  NavigationService.push(
                                      target: AirlinesIntroPage(
                                    service: data.services[0],
                                  ));
                                } else if (data.uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    "credit_card") {
                                  NavigationService.push(
                                      target: CreditCardPaymentPage(
                                    service: data.services[0],
                                  ));
                                } else if (data.uniqueIdentifier
                                            .toString()
                                            .toLowerCase() ==
                                        "landline".toLowerCase() ||
                                    data.uniqueIdentifier
                                            .toString()
                                            .toLowerCase() ==
                                        "category".toLowerCase()) {
                                  NavigationService.push(
                                      target: LandlinePaymentPage(
                                    category: data,
                                  ));
                                } else {
                                  NavigationService.push(
                                    target: CategoriesWiseServicePage(
                                        uniqueIdentifier: data.uniqueIdentifier,
                                        services: data.services,
                                        topBarName: data.name),
                                  );
                                }
                              },
                              child: Column(
                                children: [
                                  data.isNew == true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              decoration: BoxDecoration(
                                                  color:
                                                      CustomTheme.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(
                                                  'New',
                                                  style: _textTheme.bodyLarge!
                                                      .copyWith(
                                                          color:
                                                              CustomTheme.white,
                                                          fontSize: 10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  Container(
                                    height: _height * 0.03,
                                    child: _imageUrl
                                            .toLowerCase()
                                            .contains("svg")
                                        ? SvgPicture.network(
                                            _imageUrl,
                                            placeholderBuilder:
                                                (BuildContext context) =>
                                                    Center(
                                              child: Image.asset(
                                                Assets.logoImage,
                                              ),
                                            ),
                                          )
                                        : Image.network(
                                            _imageUrl,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Center(
                                                child: Image.asset(
                                                  Assets.logoImage,
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Center(
                                      child: Text(
                                        "${data.name}",
                                        textAlign: TextAlign.center,
                                        style: _textTheme.titleSmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  filteredItems.isNotEmpty
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 4),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          decoration: BoxDecoration(
                                              color: CustomTheme.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Text(
                                            "${filteredItems[0].cashBackView} cashback",
                                            overflow: TextOverflow.ellipsis,
                                            style: _textTheme.bodyLarge!
                                                .copyWith(
                                                    color: CustomTheme.white,
                                                    fontSize: 10),
                                          ),
                                        )
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 8),
                                        ),
                                ],
                              ),
                            );
                          })),
                ),
                widget.showAllService
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          NavigationService.pushNamed(
                              routeName: Routes.allServicesDashboard);
                        },
                        child: const Text("View More")),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
