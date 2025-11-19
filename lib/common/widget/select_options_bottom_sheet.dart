import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';

import 'package:ismart/common/widget/common_button.dart';

class SelectOptionsBottomSheetWrapper extends StatelessWidget {
  const SelectOptionsBottomSheetWrapper({
    Key? key,
    required this.items,
    required this.itemSelection,
    required this.onSelectCallback,
  }) : super(key: key);
  final List<String> items;
  final ValueNotifier<int> itemSelection;
  final Function(int)? onSelectCallback;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _width = SizeUtils.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 150.hp,
            width: _width / 2,
            child: CupertinoPicker.builder(
              backgroundColor: _theme.scaffoldBackgroundColor,
              itemExtent: 45,
              childCount: items.length,
              selectionOverlay: Container(
                height: 45,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
              diameterRatio: 1.1,
              squeeze: 1,
              itemBuilder: (context, index) {
                return Container(
                  height: 45,
                  alignment: Alignment.center,
                  child: Text(
                    items[index],
                    textScaleFactor: SizeUtils.textScaleFactor,
                    style: _theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.hp,
                    ),
                  ),
                );
              },
              onSelectedItemChanged: (value) {
                itemSelection.value = value;
                if (onSelectCallback != null) {
                  onSelectCallback!(value);
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: 20.hp,
        ),
        CustomRoundedButtom(
          title: "Continue",
          onPressed: () {
            NavigationService.pop();
          },
        ),
      ],
    );
  }
}
