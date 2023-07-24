import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';

class FilterChipWidget extends StatefulWidget {
  FilterChipWidget({
    Key? key,
    required this.chipText,
    required this.onSelectionCallback,
    required this.isOptionSelected,
  }) : super(key: key);
  final String chipText;
  final Function(bool) onSelectionCallback;

  final bool isOptionSelected;

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool isSelected = false;

  @override
  void initState() {
    isSelected = widget.isOptionSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return GestureDetector(
      onTap: () {
        isSelected = !isSelected;
        widget.onSelectionCallback(isSelected);
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.all(10.hp),
        padding: EdgeInsets.all(15.hp),
        decoration: BoxDecoration(
          border: Border.all(
            color: _theme.primaryColor,
          ),
          color: isSelected ? _theme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(22.hp),
        ),
        child: Text(
          "${widget.chipText}",
          style: _textTheme.subtitle1!.copyWith(
            color: isSelected ? Colors.white : _theme.primaryColor,
          ),
        ),
      ),
    );
  }
}
