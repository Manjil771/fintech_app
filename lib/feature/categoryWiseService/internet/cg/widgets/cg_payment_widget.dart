import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/internet/cg/screens/cg_payment_detail_screen.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class CgPaymentWidget extends StatefulWidget {
  const CgPaymentWidget({Key? key, required this.service}) : super(key: key);
  final ServiceList service;

  @override
  State<CgPaymentWidget> createState() => _CgPaymentWidgetState();
}

class _CgPaymentWidgetState extends State<CgPaymentWidget> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
            final UtilityResponseData _response = state.data;

            if (_response.code == "M0000") {
              NavigationService.push(
                target: CgPaymentDeatilScreen(
                  service: widget.service,
                  detailFetchData: _response,
                ),
              );
            } else {
              showPopUpDialog(
                  context: context,
                  message: _response.message,
                  title: "Error",
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                  showCancelButton: false);
            }
          }
        },
        child: Form(
          key: _formKey,
          child: CommonContainer(
            showRecentTransaction: true,
            topbarName: "Payment",
            buttonName: LocaleKeys.Proceed.tr(),
            title: 'Internet Payment',
            detail: 'Pay your internet bill of your ISP from here',
            associatedId: widget.service.id.toString(),
            showAccountSelection: false,
            showDetail: true,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          //color: _theme.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(18)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                              "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.service.icon}")),
                    ),
                    Expanded(
                      child: Text(widget.service.service,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  )),
                    ),
                  ],
                ),
                SizedBox(height: _height * 0.03),
                Text("Provide Username and Details to pay.",
                    style: Theme.of(context).textTheme.labelMedium),
                SizedBox(height: _height * 0.03),
                CustomTextField(
                  textInputType: TextInputType.phone,
                  title: 'User Id',
                  controller: _usernameController,
                  hintText: 'Enter User Id',
                  validator: (value) =>
                      FormValidator.validateFieldNotEmpty(value, 'Username'),
                ),
              ],
            ),
            onButtonPressed: () {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                onButtonPressed(username: _usernameController.text);
              }
            },
          ),
        ),
      ),
    );
  }

  void onButtonPressed({required String username}) {
    context.read<UtilityPaymentCubit>().fetchDetails(
          serviceIdentifier: widget.service.uniqueIdentifier,
          accountDetails: {
            "userId": username,
          },
          apiEndpoint: "api/cg_net/customer_details",
        );
  }
}
