import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/electricity/screen/electricity_search_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';

class ElectricityPaymentWidget extends StatefulWidget {
  const ElectricityPaymentWidget({Key? key}) : super(key: key);

  @override
  State<ElectricityPaymentWidget> createState() =>
      _ElectricityPaymentWidgetState();
}

class _ElectricityPaymentWidgetState extends State<ElectricityPaymentWidget> {
  KeyValue? selectedCounter;

  final TextEditingController _selectedCounterController =
      TextEditingController();

  final TextEditingController _scNumberController = TextEditingController();
  final TextEditingController _customerIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        title: "NEA Payment",
        detail: "Pay for your electricity bill from here.",
        body: BlocListener<UtilityPaymentCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonStateSuccess) {
              print(state.data);
            }
          },
          child: Column(
            children: [
              CustomTextField(
                title: "Select Counter",
                hintText: "Select From List",
                readOnly: true,
                suffixIcon: Icons.arrow_downward,
                showSearchIcon: true,
                controller: _selectedCounterController,
                onTap: () {
                  NavigationService.push(target: ElectricityCounterSearchPage(
                    onChanged: (val) {
                      selectedCounter = val;
                      _selectedCounterController.text =
                          selectedCounter?.title ?? "";
                    },
                  ));
                },
              ),
              CustomTextField(
                title: "SC No.",
                hintText: "Enter SC Number", //Need to add dropdown button
                controller: _scNumberController,
              ),
              CustomTextField(
                title: "Customer Id",
                hintText: "ID", //Need to add dropdown button
                controller: _customerIDController,
              ),
            ],
          ),
        ),
        buttonName: "Procced",
        onButtonPressed: () {
          context.read<UtilityPaymentCubit>().fetchDetails(
                serviceIdentifier: "nea_online_topup",
                accountDetails: {
                  "scno": _scNumberController.text,
                  "office_code": selectedCounter?.value ?? "",
                  "customerId": _customerIDController.text,
                },
                apiEndpoint: "/api/getneabill",
              );
        },
        topbarName: "Payment",
      ),
    );
  }
}
