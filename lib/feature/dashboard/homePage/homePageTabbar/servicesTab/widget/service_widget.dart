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
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/all_service_screen.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/service_screen.dart';

class ServicesWidget extends StatefulWidget {
  final bool showAllService;
  ServicesWidget({Key? key, this.showAllService = true}) : super(key: key);

  @override
  State<ServicesWidget> createState() => _ServicesWidgetState();
}

class _ServicesWidgetState extends State<ServicesWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().fetchServices();
  }

  final screens = [
    Routes.mobileTopup,
    Routes.electricityPayment,
    Routes.internetList,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
    Routes.mobileTopup,
  ];

  final List images = [
    Assets.topupPaymentIcon,
    Assets.electricityIcon,
    Assets.internetIcon,
    Assets.airlineIcon,
    Assets.waterIcon,
    Assets.insuranceIcon,
    Assets.busIcon,
    Assets.tvIcon,
    Assets.dataPackIcon,
    Assets.ridepaymentIcon,
    Assets.governmentIcon,
    Assets.brokerIcon,
    Assets.landlineIcon,
  ];

  final names = [
    "Top Up",
    "Electricity",
    "Internet",
    "Air Ticket",
    "Water",
    "Insurance",
    "Bus Ticket",
    "Television",
    "Data Packs",
    "Ride",
    "Government Payment",
    "Broker",
  ];
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
        }, builder: (context, state) {
          if (state is CommonStateSuccess<List<ServiceModel>>) {
            return Container(
              child: Text("scccess"),
            );
          } else {
            return Text(state.toString());
          }
          //     builder: (context, state) {
          //       if (state is CommonStateSuccess<List<ServiceModel>>) {
          //         return Container(
          //           height: 500,
          //           width: 500,
          //           child: GridView.builder(
          //             itemCount: widget.showAllService ? 12 : 8,
          //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 4,
          //             ),
          //             itemBuilder: (context, index) => InkWell(
          //               onTap: () {
          //                 NavigationService.pushNamed(routeName: screens[index]);
          //               },
          //               child: Column(
          //                 children: [
          //                   SvgPicture.asset(
          //                     "${images[index]}",
          //                     height: _height * 0.03,
          //                   ),
          //                   SizedBox(height: _height * 0.02),
          //                   Expanded(
          //                     child: Text(
          //                       "${names[index]}".toString(),
          //                       style: _textTheme.titleSmall,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         );
          //       } else {
          //         return Container();
          //       }
          //     },
          //   ),
        }));
  }
}
//  Expanded(
//             child: GridView.builder(
//               itemCount: widget.showAllService ? 12 : 8,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//               ),
//               itemBuilder: (context, index) => InkWell(
//                 onTap: () {
//                   NavigationService.pushNamed(routeName: screens[index]);
//                 },
//                 child: Column(
//                   children: [
//                     SvgPicture.asset(
//                       "${images[index]}",
//                       height: _height * 0.03,
//                     ),
//                     SizedBox(height: _height * 0.02),
//                     Expanded(
//                       child: Text(
//                         "${names[index]}".toString(),
//                         style: _textTheme.titleSmall,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),  // showAllService
          //     ? Container()
          //     : TextButton(
          //         onPressed: () {
          //           NavigationService.pushNamed(
          //               routeName: Routes.allServicesDashboard);
          //         },
          //         child: const Text("View More"))