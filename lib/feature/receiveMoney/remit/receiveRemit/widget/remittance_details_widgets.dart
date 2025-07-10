import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';

class RemittanceDetailsWidgets extends StatefulWidget {
  final String companyID;

  RemittanceDetailsWidgets({super.key, required this.companyID});

  @override
  State<RemittanceDetailsWidgets> createState() =>
      _RemittanceDetailsWidgetsState();
}

class _RemittanceDetailsWidgetsState extends State<RemittanceDetailsWidgets> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _remittancepin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UtilityPaymentCubit, CommonState>(
      listener: (context, state) {
        child:
        PageWrapper(
            body: CommonContainer(
          topbarName: "Remittance",
          title: "Remittance",
          detail: "Fetch your Remittance details from here",
          buttonName: "Procced",
          onButtonPressed: () {
            onButtonPressed();
            ;
          },
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  title: "Pin",
                  hintText: "xxxxxxxxxx",
                  textInputType: TextInputType.number,
                  controller: _remittancepin,
                )
              ],
            ),
          ),
        ));
      },
    );
  }

  void onButtonPressed() {
    context.read<UtilityPaymentCubit>().fetchDetails(
          serviceIdentifier: "",
          accountDetails: {
            "transactionPin": _remittancepin.text,
            "remittanceCompanyId": widget.companyID
          },
          apiEndpoint: "api/remittance/transactionDetail",
        );
  }
}
