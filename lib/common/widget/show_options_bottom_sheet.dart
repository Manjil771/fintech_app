import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/select_options_bottom_sheet.dart';
import 'package:ismart/common/wrapper/bottom_sheet_wrapper.dart';

selectOptionsBottomSheet(
  context,
  List<String> items,
  ValueNotifier<int> itemSelection,
  Function(int)? onSelectCallback,
  String title,
) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.hp)),
    builder: (context) {
      return BottomSheetWrapper(
        padding: EdgeInsets.symmetric(
          horizontal: 20.hp,
          vertical: 30.hp,
        ),
        title: title,
        child: SelectOptionsBottomSheetWrapper(
          items: items,
          itemSelection: itemSelection,
          onSelectCallback: onSelectCallback,
        ),
        showTopDivider: false,
      );
    },
  );
}
