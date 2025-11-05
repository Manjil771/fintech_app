import 'package:flutter/material.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/custom_icon_button.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/search_widget.dart';
import 'package:ismart/feature/categoryWiseService/tvPayment/resources/tv_detail_model.dart';

class TvPackageSearchWidgets extends StatelessWidget {
  final List<TvPackages> tvpackage;
  final ValueChanged<TvPackages> onChanged;
  const TvPackageSearchWidgets({
    Key? key,
    required this.onChanged,
    required this.tvpackage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TvPackages> _items = List.from(tvpackage);

    return PageWrapper(
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
          final _index = _items.indexWhere((e) => e.text == val.title);
          if (_index != -1) {
            onChanged(_items[_index]);
          }
        },
        items: List.generate(
          _items.length,
          (index) => KeyValue(
            title: _items[index].text ?? "",
            value: "Rs. ${_items[index].amount}",
          ),
        ),
      ),
    );
  }
}
