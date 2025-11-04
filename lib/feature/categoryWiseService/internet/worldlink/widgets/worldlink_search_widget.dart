import 'package:flutter/material.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/amount_utils.dart';
import 'package:ismart/common/widget/custom_icon_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/search_widget.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class WorldlinkSearchWidgets extends StatelessWidget {
  final ValueChanged<Map<String, dynamic>> onChanged;
  final UtilityResponseData useServiceResponse;
  final bool renewOptions;
  const WorldlinkSearchWidgets({
    Key? key,
    required this.onChanged,
    required this.useServiceResponse,
    required this.renewOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List _items = List.from((renewOptions
            ? useServiceResponse.findValue(primaryKey: "packages")
            : useServiceResponse.findValue(primaryKey: "package_options")) ??
        []);

    return PageWrapper(
      showBackButton: true,
      leadingAppIcon: CustomIconButton(
        icon: Icons.close_rounded,
        shadow: false,
        backgroundColor: Colors.transparent,
        onPressed: () {
          NavigationService.pop();
        },
      ),
      title: "Renew Options",
      padding: EdgeInsets.zero,
      body: SearchWidgets(
        onChanged: (val) {
          final _index = _items.indexWhere((e) => e["text"] == val.title);
          if (_index != -1) {
            onChanged(_items[_index]);
          }
        },
        items: List.generate(
          _items.length,
          (index) => KeyValue(
            title: _items[index]["text"],
            value:
                "Rs. ${AmountUtils.getAmountInRupees(amount: _items[index]["amount"]?.toString() ?? "")}",
          ),
        ),
      ),
    );
  }
}
