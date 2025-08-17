import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/remittancepayment_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class AllremittanceDetailsWidget extends StatelessWidget {
  final ScrollController scrollController;
  const AllremittanceDetailsWidget({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;

    return BlocBuilder<UtilityPaymentCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonStateSuccess<UtilityResponseData>) {
          final List<dynamic> remits = state.data.findValue(primaryKey: "data");

          if (remits.isEmpty) {
            return const NoDataScreen(
                title: "Not Found", details: "No remittance details found.");
          }
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: List.generate(remits.length, (index) {
                final item = remits[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: CustomTheme.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Text(
                        "Remittance from ${item["senderName"] ?? "Unknown"}",
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: _height * 0.02),
                      Text(
                        "Details for remittance ID ${item["remittanceId"]}",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(height: _height * 0.02),
                      const Divider(thickness: 1),
                      SizedBox(height: _height * 0.02),
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFF3F3F3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Transaction Details",
                                style: Theme.of(context).textTheme.titleLarge),
                            SizedBox(height: _height * 0.02),
                            KeyValueTile(
                                title: "Receiver Name",
                                value: item["receiverName"] ?? ""),
                            KeyValueTile(
                                title: "Receiver Mobile",
                                value: item["receiverMobileNumber"] ?? ""),
                            KeyValueTile(
                                title: "Sender Name",
                                value: item["senderName"] ?? ""),
                            KeyValueTile(
                                title: "Sender Country",
                                value: item["senderCountry"] ?? ""),
                            KeyValueTile(
                                title: "Amount",
                                value: item["amount"].toString()),
                            KeyValueTile(
                                title: "Pay Type",
                                value: item["payType"] ?? ""),
                            KeyValueTile(
                                title: "Token ID",
                                value: item["payTokenId"] ?? ""),
                            KeyValueTile(
                                title: "PIN", value: item["pinNo"] ?? ""),
                            KeyValueTile(
                                title: "Date", value: item["date"] ?? ""),
                            KeyValueTile(
                                title: "Status", value: item["status"] ?? ""),
                          ],
                        ),
                      ),
                      SizedBox(height: _height * 0.02),
                      ValueListenableBuilder<CategoryList?>(
                          valueListenable:
                              RepositoryProvider.of<CategoryRepository>(context)
                                  .remitCategory,
                          builder: (context, val, _) {
                            return CustomRoundedButtom(
                                title: "Proceed",
                                onPressed: () {
                                  NavigationService.push(
                                      target: RemittancepaymentPage(
                                    service: val!.services.first,
                                    id: item["id"].toString(),
                                  ));
                                });
                          }),
                    ],
                  ),
                );
              }),
            ),
          );
        } else if (state is CommonLoading) {
          return const CommonLoadingWidget();
        } else {
          return const NoDataScreen(
            title: "Not Found",
            details: "No remittance records available.",
          );
        }
      },
    );
  }
}
