import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/services/internet/ui/screens/internet_payment_detail_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../../../common/util/size_utils.dart';

class FindInternetUserWidget extends StatefulWidget {
  @override
  State<FindInternetUserWidget> createState() => _FindInternetUserWidgetState();
}

class _FindInternetUserWidgetState extends State<FindInternetUserWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: BlocListener<UtilityPaymentCubit, CommonState>(
        listener: (context, state) {
          print(state);
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            UtilityResponseData _response = state.data;
            // if (_keyValues.isNotEmpty) {
            NavigationService.push(
              target: InternetPaymentDeatilScreen(
                detailFetchData: _response,
              ),
            );
            // }
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const ScaffoldTopBar(name: "Payment", back: true),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Internet Payment",
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      "Pay your internet bill of you ISP from here",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    SizedBox(height: _height * 0.03),
                    Row(
                      children: [
                        Container(
                          height: _height * 0.1,
                          width: _width * 0.2,
                          margin: const EdgeInsets.only(right: 18),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.05),
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                              color: _theme.primaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(18)),
                        ),
                        Expanded(
                          child: Text("World Link Communications Pvt. Ltd.",
                              style: _textTheme.titleMedium),
                        ),
                      ],
                    ),
                    SizedBox(height: _height * 0.03),
                    Text(
                        "Provide Username to fetch details and pay respective amount.",
                        style: Theme.of(context).textTheme.labelMedium),
                    SizedBox(height: _height * 0.03),
                    CustomTextField(
                      hintText: "abcd123",
                      controller: _usernameController,
                      validator: (val) =>
                          FormValidator.validateFieldNotEmpty(val, "Username"),
                    ),
                    SizedBox(height: _height * 0.05),
                    CustomRoundedButtom(
                        title: "Procced",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<UtilityPaymentCubit>().fetchDetails(
                                  serviceIdentifier: "worldlink_online_topup",
                                  accountDetails: {
                                    "wlink_username": _usernameController.text,
                                  },
                                  apiEndpoint: "api/wlinkpackages",
                                );

                            // context.read<UtilityPaymentCubit>().fetchDetails(
                            //       serviceIdentifier: "",
                            //       accountDetails: {},
                            //       apiEndpoint: "get/neaofficecode",
                            //     );
                          }
                          // NavigationService.pushNamed(
                          //   routeName: Routes.internetPaymentDetail,
                          // );
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
