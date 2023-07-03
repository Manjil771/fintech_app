import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/fonts.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/dashboard/homePage/screen/home_page.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class CommonBillDetailPage extends StatelessWidget {
  final String image;
  final String serviceType;
  final Widget body;
  final Function()? onButtonPress;
  final Function()? onSuccessState;

  CommonBillDetailPage(
      {super.key,
      required this.image,
      required this.body,
      required this.serviceType,
      this.onButtonPress,
      this.onSuccessState});
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
        utilityPaymentRepository:
            RepositoryProvider.of<UtilityPaymentRepository>(context),
      ),
      child: CommonBillDetailWidget(
          onSuccessState: onSuccessState,
          onButtonPress: onButtonPress!,
          body: body,
          image: image,
          serviceType: serviceType),
    );
  }
}

class CommonBillDetailWidget extends StatelessWidget {
  final String image;
  final Function()? onSuccessState;

  final String serviceType;
  final Widget body;
  final Function() onButtonPress;
  CommonBillDetailWidget(
      {super.key,
      required this.image,
      required this.body,
      required this.serviceType,
      required this.onButtonPress,
      this.onSuccessState});
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return PageWrapper(
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }

          if (state is CommonStateSuccess) {
            onSuccessState!();
          } else if (state is CommonError) {
            print(
                " state is successas hjjagfhjfgjsdghjfgdsjhf hdsgfjdshfjsdgfsfdghj fsgdhjfdsf");
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CustomTheme.white,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(
                    image,
                    height: _height * 0.08,
                  ),
                  SizedBox(height: _height * 0.02),
                  Text(
                    serviceType,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: _height * 0.02),
                  Text(
                      "Details about the payable amount for the service of $serviceType is shown below.",
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Paymet Details",
                            style: Theme.of(context).textTheme.titleLarge),
                        SizedBox(height: _height * 0.02),
                        body,
                      ],
                    ),
                  ),
                  SizedBox(height: _height * 0.02),
                  CustomRoundedButtom(title: "Pay", onPressed: onButtonPress),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(18),
                  //       border:
                  //           Border.all(color: Theme.of(context).primaryColor)),
                  //   child: CustomRoundedButtom(
                  //       textColor: Theme.of(context).primaryColor,
                  //       title: "Download Receipt",
                  //       color: Colors.transparent,
                  //       onPressed: () {}),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
