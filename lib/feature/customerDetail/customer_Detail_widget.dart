import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';

class CustomerDEtailWidget extends StatefulWidget {
  @override
  State<CustomerDEtailWidget> createState() => _CustomerDEtailWidgetState();
}

class _CustomerDEtailWidgetState extends State<CustomerDEtailWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<CustomerDetailCubit>().fetchCustomerDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    bool _isLoading = false;

    return PageWrapper(
      showAppBar: false,
      body: BlocListener<CustomerDetailCubit, CommonState>(
        listener: (CustomerDetailCubit, CommonState) {
          if (CommonState is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (CommonState is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }

          if (CommonState is CommonStateSuccess) {
            const Text("Adsa");
          } else if (CommonState is CommonError) {
            showPopUpDialog(
              context: context,
              message: CommonState.message,
              title: "Error",
              showCancelButton: false,
              buttonCallback: () {
                NavigationService.pop();
              },
            );
          }
        },
        child: const Text("Success"),
      ),
    );
  }
}
