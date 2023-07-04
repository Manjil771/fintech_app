import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LandLinePaymentWidget extends StatelessWidget {
  LandLinePaymentWidget({Key? key}) : super(key: key);
  final phoneNumberController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocListener(
      listener: (context, state) {
        if (state is CommonStateSuccess<UtilityResponseData>) {}
      },
      child: PageWrapper(
        body: CommonContainer(
          showAccountSelection: true,
          buttonName: "Pay",
          showDetail: true,
          title: "Landline Payement",
          detail: "Pay for your landline subscription from here.",
          topbarName: "Landline",
          body: Column(
            children: [
              CustomTextField(
                title: "Landline Number",
                hintText: "XXXXXXXXX",
              ),
              CustomTextField(
                title: "Amount",
                hintText: "NPR.",
              ),
            ],
          ),
          onButtonPressed: () {
            NavigationService.push(
              target: TransactionPinScreen(
                onValueCallback: (mpin) {
                  NavigationService.pop();
                  context.read<UtilityPaymentCubit>().getTopUp(
                        serviceIdentifier: "",
                        phoneNumber: phoneNumberController.text,
                        amount: amountController.text,
                        mpin: mpin,
                      );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
