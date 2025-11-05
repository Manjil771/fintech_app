import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class SmartLoanDetailWidget extends StatelessWidget {
  final UtilityResponseData res;
  const SmartLoanDetailWidget({super.key, required this.res});

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
        body: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: CustomTheme.white, borderRadius: BorderRadius.circular(16)),
      child: ListView(
        children: [
          Text(
            "Loan Details",
            style:
                _textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "Details of Loan is shown below.",
            style: _textTheme.labelLarge!.copyWith(color: Colors.grey),
          ),
          SizedBox(
            height: 10.hp,
            child: const Divider(),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: res.details.length,
              itemBuilder: (context, index) {
                final List data = res.findValue(primaryKey: "data");
                return Column(
                  children: [
                    KeyValueTile(
                        title: "Full Name",
                        
                        value: data[index]["firstName"] +
                            " " +
                            data[index]["lastName"]),
                    KeyValueTile(
                        title: "Mobile Number",
                        value: data[index]["mobileNumber"]),
                    KeyValueTile(
                        title: "Remarks",
                        value: data[index]["customerRemarks"]),
                    KeyValueTile(
                        title: "Requested Amount",
                        value: data[index]["requestedAmount"].toString()),
                    KeyValueTile(
                        title: "Account Number",
                        value: data[index]["accountNumber"]),
                    KeyValueTile(
                        title: "Account Type",
                        value: data[index]["accountType"]),
                    KeyValueTile(title: "Status", value: data[index]["status"]),
                  ],
                );
              }),
          SizedBox(height: 20.hp),
          CustomRoundedButtom(
              title: "Close",
              onPressed: () {
                NavigationService.pushNamedAndRemoveUntil(
                    routeName: Routes.dashboard);
              })
        ],
      ),
    ));
  }
}
