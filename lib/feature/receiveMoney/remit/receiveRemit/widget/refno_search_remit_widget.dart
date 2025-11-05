// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/reveice_remit_details_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class RefnoSearchRemitWidget extends StatelessWidget {
  final String serviceId;
  final String companyName;
  final String imageUrl;

  RefnoSearchRemitWidget(
      {super.key,
      required this.serviceId,
      required this.companyName,
      required this.imageUrl});
  bool _isLoading = false;

  final TextEditingController _refNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _width = SizeUtils.width;
    return PageWrapper(
      body: CommonContainer(
          onButtonPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<UtilityPaymentCubit>().makePayment(
                  serviceIdentifier: "",
                  accountDetails: {},
                  body: {
                    "serviceName": serviceId,
                    "referenceno": _refNoController.text
                  },
                  apiEndpoint: "api/remittance/searchReference",
                  mPin: "");
            }
          },
          title: "Receive Remit",
          buttonName: "Next",
          body: Form(
            key: _formKey,
            child: BlocListener<UtilityPaymentCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonLoading && _isLoading == false) {
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

                if (state is CommonStateSuccess<UtilityResponseData>) {
                  final UtilityResponseData _response = state.data;
                  if (_response.code == "M0000" ||
                      _response.status.toLowerCase() == "success") {
                    NavigationService.push(
                        target: const ReceiveRemitDetailPage());
                  } else {
                    showPopUpDialog(
                      context: context,
                      message: _response.message,
                      title: _response.status,
                      showCancelButton: false,
                      buttonCallback: () {
                        NavigationService.pop();
                      },
                    );
                  }
                }
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 90,
                        padding: const EdgeInsets.all(8),
                        width: _width * 0.25,
                        margin: const EdgeInsets.only(right: 18),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.05),
                                offset: const Offset(0, 4),
                                blurRadius: 1,
                              ),
                            ],
                            //color: _theme.primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(18)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CustomCachedNetworkImage(
                            url: RepositoryProvider.of<CoOperative>(context)
                                    .baseUrl +
                                imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          companyName,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.hp),
                  CustomTextField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => FormValidator.validateFieldNotEmpty(
                        value, "Refrence Number"),
                    title: "Refrence No.",
                    controller: _refNoController,
                  ),
                ],
              ),
            ),
          ),
          topbarName: "Remittance"),
    );
  }
}
