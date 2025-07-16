import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ForexWidget extends StatefulWidget {
  const ForexWidget({super.key});

  @override
  State<ForexWidget> createState() => _ForexWidgetState();
}

class _ForexWidgetState extends State<ForexWidget> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        showBackButton: true,
        showChatBot: false,
        body: BlocListener<UtilityPaymentCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonStateSuccess) {
              final UtilityResponseData _res = state.data;
              if (_res.code == "M0000") {}
            }
          },
          child: const Center(
            child: Text('This is foreex'),
          ),
        ));
  }
}
