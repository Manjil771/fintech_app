import 'package:flutter/material.dart';
import 'package:ismart/common/enum/counters_fetch_enum.dart';
import 'package:ismart/common/models/key_value.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/electricity/widget/nea_search_widget.dart';

class CounterSearchPage extends StatelessWidget {
  final CountersEnums counterType;
  const CounterSearchPage({
    Key? key,
    required this.onChanged,
    required this.counterType,
  }) : super(key: key);

  final Function(KeyValue?) onChanged;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return CountersSearchWidget(
      onChanged: onChanged,
      countersEnums: counterType,
    );
  }
}
