import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/enum/counters_fetch_enum.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/screen/khanepani_detail_screen.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_search_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class KhanePaniWidget extends StatefulWidget {
  const KhanePaniWidget({Key? key}) : super(key: key);

  @override
  State<KhanePaniWidget> createState() => _KhanePaniWidgetState();
}

class _KhanePaniWidgetState extends State<KhanePaniWidget> {
  final TextEditingController _selectedCounterController =
      TextEditingController();

  final TextEditingController _customerIdController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  KeyValue? selectedCounter;
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
          if (state is CommonLoading && !_isLoading) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            NavigationService.pop();
          }

          if (state is CommonStateSuccess<UtilityResponseData>) {
            if (state.data.code == "M0000") {
              NavigationService.push(
                  target: KhanepaniDetailsPage(
                counterName: selectedCounter?.title ?? "",
                customerCode: _customerIdController.text,
                useServiceResponse: state.data,
                counterCode: selectedCounter?.value ?? "",
              ));
            } else {
              showPopUpDialog(
                  context: context,
                  message: state.data.message,
                  title: "Error",
                  buttonCallback: () {
                    NavigationService.pop();
                  },
                  showCancelButton: false);
            }
          }
        },
        child: CommonContainer(
            buttonName: "Show Bill",
            showAccountSelection: true,
            title: "Khane Pani",
            detail: "Pay for your water bill from here.",
            showDetail: true,
            topbarName: "Khane Pani",
            onButtonPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<UtilityPaymentCubit>().fetchDetails(
                      serviceIdentifier: "",
                      accountDetails: {
                        "customer_code": _customerIdController.text,
                        "counter": selectedCounter?.value ?? "",
                        "month_id": 0,
                      },
                      apiEndpoint: "api/getkhanepanibill",
                    );
              }
            },
            body: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    title: "Select Counter",
                    hintText: "Select From List",
                    readOnly: true,
                    validator: (val) =>
                        FormValidator.validateFieldNotEmpty(val, "Counter"),
                    controller: _selectedCounterController,
                    onTap: () {
                      NavigationService.push(
                        target: CounterSearchPage(
                          counterType: CountersEnums.Khanepani,
                          onChanged: (val) {
                            selectedCounter = val;
                            _selectedCounterController.text =
                                selectedCounter?.title ?? "";
                          },
                        ),
                      );
                    },
                  ),
                  CustomTextField(
                    title: "Customer code",
                    hintText: "XXXXXXXXX",
                    controller: _customerIdController,
                    validator: (val) => FormValidator.validateFieldNotEmpty(
                        val, "Customer Code"),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
