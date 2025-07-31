import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class MapsWidgets extends StatelessWidget {
  const MapsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: BlocBuilder<UtilityPaymentCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonStateSuccess<UtilityResponseData>) {
            final data = state.data;
            final List<KeyValue> detail = data.detail;
            print("yoyoy$detail[0]");

            if (detail is List) {
              return ListView.builder(
                itemCount: detail.length,
                itemBuilder: (context, index) {
                  final branch = detail[index] as Map<String, dynamic>;
                  return ListTile(
                    title: Text(branch['name'] ?? 'No Name'),
                    subtitle: Text(
                      "Lat: ${branch['latitude'] ?? '-'}, Lng: ${branch['longitude'] ?? '-'}",
                    ),
                  );
                },
              );
            } else if (detail is String && detail.isEmpty) {
              return const NoDataScreen(
                title: "No Branches Found",
                details: "No location data was returned from the server.",
              );
            } else {
              return const NoDataScreen(
                title: "Invalid Data",
                details: "Branch data is not in the expected format.",
              );
            }
          } else if (state is CommonLoading) {
            return const CommonLoadingWidget();
          } else {
            return const NoDataScreen(
              title: "Not Found",
              details: "No remit list found.",
            );
          }
        },
      ),
    );
  }
}
