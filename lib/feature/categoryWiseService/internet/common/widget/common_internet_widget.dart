import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/internet/common/screen/common_internet_payment_detail_page.dart';
import 'package:ismart/feature/categoryWiseService/internet/ui/screens/internet_payment_detail_screen.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../../../common/util/size_utils.dart';

class CommonFindInternetUserWidget extends StatefulWidget {
  CommonFindInternetUserWidget({Key? key, required this.service})
      : super(key: key);

  final ServiceList service;

  @override
  State<CommonFindInternetUserWidget> createState() =>
      _CommonFindInternetUserWidgetState();
}

class _CommonFindInternetUserWidgetState
    extends State<CommonFindInternetUserWidget> {
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
                buttonCallback: () {
                  NavigationService.pop();
                },
                showCancelButton: false);
          }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            final UtilityResponseData _response = state.data;
            if (_response.code == "M0000") {
              NavigationService.push(
                target: CommonInternetPaymentDeatilScreen(
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
            showDetail: true,
            title: widget.service.service,
            detail: widget.service.instructions,
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
                            "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${widget.service.icon}"),
                      ),
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
                Text(
                    "Provide Username to fetch details and pay respective amount.",
                    style: Theme.of(context).textTheme.labelMedium),
                SizedBox(height: _height * 0.03),
                CustomTextField(
                  title: 'Username',
                  controller: _usernameController,
                  hintText: 'Enter Username',
                  validator: (value) =>
                      FormValidator.validateFieldNotEmpty(value, 'Username'),
                ),
              ],
            ),
            topbarName: 'Payment',
            buttonName: 'Proceed',
            onButtonPressed: () {
              _formKey.currentState!.save();
              if (_formKey.currentState!.validate()) {
                context.read<UtilityPaymentCubit>().fetchDetails(
                      serviceIdentifier: widget.service.uniqueIdentifier,
                      accountDetails: {
                        "username": _usernameController.text,
                      },
                      apiEndpoint: "api/internetpackages",
                    );
              }
            },
          ),
        ),
      ),
    );
  }
}
