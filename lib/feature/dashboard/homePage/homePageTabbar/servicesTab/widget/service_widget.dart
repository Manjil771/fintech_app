import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/service_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/services_model.dart';
import 'package:ismart/feature/profile/screen/profile_page.dart';
import 'package:ismart/feature/services/Topup/ui/screens/mobile_topup_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/list_app_services_page.dart';

class ServicesWidget extends StatefulWidget {
  final bool showAllService;
  const ServicesWidget({Key? key, this.showAllService = true})
      : super(key: key);

  @override
  State<ServicesWidget> createState() => _ServicesWidgetState();
}

class _ServicesWidgetState extends State<ServicesWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().fetchServices();
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
      child: BlocConsumer<ServicesCubit, CommonState>(
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
          if (state is CommonStateSuccess<List<ServicesList>>) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                      //  color: Colors.greenAccent.withOpacity(0.1),
                      child: GridView.builder(
                          // itemCount: 5,
                          itemCount: widget.showAllService
                              ? state.data.length
                              : state.data.length >= 12
                                  ? 12
                                  : state.data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 0.5 / 0.5),
                          itemBuilder: (context, index) {
                            final data = state.data[index];
                            final _imageUrl =
                                "https://ismart.devanasoft.com.np/${data.imageUrl}";
                            return InkWell(
                              onTap: () {
                                if (data.uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    "topup") {
                                  NavigationService.pushNamed(
                                      routeName: Routes.mobileTopup);
                                } else if (data.uniqueIdentifier
                                        .toString()
                                        .toLowerCase() ==
                                    "electricity") {
                                  NavigationService.pushNamed(
                                      routeName: Routes.electricityPayment);
                                } else {
                                  NavigationService.push(
                                    target: ListAppServicesPage(
                                        services: data.services,
                                        topBarName: data.name),
                                  );
                                }
                              },
                              child: Column(
                                children: [
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 8),
                                    child: Text(
                                      "${data.name}",
                                      textAlign: TextAlign.center,
                                      style: _textTheme.titleSmall,
                                    ),
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
