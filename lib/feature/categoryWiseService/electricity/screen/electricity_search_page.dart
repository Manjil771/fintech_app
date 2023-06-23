import 'package:flutter/material.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/electricity/widget/nea_search_widget.dart';

class ElectricityCounterSearchPage extends StatelessWidget {
  const ElectricityCounterSearchPage({Key? key, required this.onChanged})
      : super(key: key);

  final Function(KeyValue?) onChanged;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ElectricitySearchWidget(
      onChanged: onChanged,
    );
  }
}
