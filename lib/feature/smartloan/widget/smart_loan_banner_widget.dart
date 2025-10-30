import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/feature/smartloan/screen/smart_loan_register_screen.dart';
import 'package:ismart/feature/smartloan/widget/smart_loan_details_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class SmartLoanBannerWidget extends StatefulWidget {
  const SmartLoanBannerWidget({super.key});

  @override
  State<SmartLoanBannerWidget> createState() => _SmartLoanBannerWidgetState();
}

class _SmartLoanBannerWidgetState extends State<SmartLoanBannerWidget> {
  @override
  void initState() {
    context.read<UtilityPaymentCubit>().fetchDetails(
        serviceIdentifier: "serviceIdentifier",
        accountDetails: {},
        apiEndpoint: "/api/smartLoan/details");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UtilityPaymentCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonStateSuccess<UtilityResponseData>) {
          final UtilityResponseData res = state.data;
          if (res.code == "M0000") {
            return Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 50.hp,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: CustomTheme.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(Assets.instaLoanIcon),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRoundedButtom(
                        verticalPadding: 8,
                        horizontalPadding: 16,
                        title: "View",
                        onPressed: () {
                          NavigationService.push(
                              target: SmartLoanDetailWidget(
                            res: res,
                          ));
                        },
                      ),
                    ),
                  ],
                ));
          } else {
            return Container(
                // padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 16),
                height: 50.hp,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: CustomTheme.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(Assets.instaLoanIcon),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRoundedButtom(
                        verticalPadding: 8,
                        horizontalPadding: 16,
                        title: "Apply",
                        onPressed: () {
                          NavigationService.push(
                              target: const SmartLoanRegisterScreen());
                        },
                      ),
                    ),
                  ],
                ));
          }
        } else {
          return Container();
        }
      },
    );
  }
}
