import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';

class SlidingToggleButton extends StatefulWidget {
  final List<String> options;
  final Function(int) onChanged;
  final int initialIndex;
  final double width;
  final double height;
  final Color unselectedTextColor;
  final Color selectedTextColor;

  const SlidingToggleButton({
    super.key,
    required this.options,
    required this.onChanged,
    this.initialIndex = 0,
    this.width = 200,
    this.height = 44,
    this.unselectedTextColor = Colors.black87,
    this.selectedTextColor = Colors.white,
  });

  @override
  _SlidingToggleButtonState createState() => _SlidingToggleButtonState();
}

class _SlidingToggleButtonState extends State<SlidingToggleButton> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: CustomTheme.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(
              -1 + (selectedIndex * 2 / (widget.options.length - 1)),
              0,
            ),
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Container(
              width: widget.width / widget.options.length,
              height: widget.height,
              decoration: BoxDecoration(
                color: CustomTheme.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          Row(
            children: List.generate(widget.options.length, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      widget.onChanged(index);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.options[index],
                      style: TextStyle(
                        color: selectedIndex == index
                            ? widget.selectedTextColor
                            : widget.unselectedTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
