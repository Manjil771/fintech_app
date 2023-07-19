import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/feature/categoryWiseService/airlines/cubit/airlines_cubit.dart';
import 'package:ismart/feature/categoryWiseService/airlines/model/airlines_sector_model.dart';
import 'package:ismart/feature/history/cubit/receipt_download_cubit.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/widget/transaction_detail_alert_widget.dart';

class LocationListAirlinesWidget extends StatefulWidget {
  const LocationListAirlinesWidget({Key? key}) : super(key: key);

  @override
  State<LocationListAirlinesWidget> createState() =>
      _LocationListAirlinesWidgetState();
}

class _LocationListAirlinesWidgetState
    extends State<LocationListAirlinesWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AirlinesCubit>().fetchAirlinesList();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    return PageWrapper(
      showAppBar: false,
      body: BlocConsumer<AirlinesCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && !_isLoading) {
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
        },
        builder: (context, state) {
          print("asbdjhas djsashadas djsais " + state.toString());
          if (state is CommonDataFetchSuccess<AirlinesSectorList>) {
            return Container(
              height: 150,
              width: 150,
              color: Colors.red,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
