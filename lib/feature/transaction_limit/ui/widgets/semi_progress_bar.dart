import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/number_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/transaction_limit/ui/widgets/custom_arc_painter.dart';

class SemiCircleProgressBar extends StatefulWidget {
  final String title;
  final double current;
  final double minValue;
  final double maxValue;
  final String valueUnit;
  final double width;
  final bool isCount;
  const SemiCircleProgressBar({
    Key? key,
    required this.title,
    required this.maxValue,
    required this.minValue,
    required this.current,
    required this.valueUnit,
    required this.width,
    required this.isCount,
  }) : super(key: key);

  @override
  State<SemiCircleProgressBar> createState() => _SemiCircleProgressBarState();
}

class _SemiCircleProgressBarState extends State<SemiCircleProgressBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> animations;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    final _curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutCubic,
    );

    double _progress = widget.current / widget.maxValue;

    if (_progress >= 1) {
      _progress = 1;
    }

    animations =
        Tween<double>(begin: 0, end: _progress).animate(_curvedAnimation);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
      child: Column(
        children: [
          Text(
            widget.title,
            style: _textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.hp),
          SizedBox(
            height: 75.wp,
            width: widget.width,
            child: AnimatedBuilder(
              animation: animations,
              builder: (context, _) {
                return CustomPaint(
                  painter: ProgressArc(
                    width: widget.width,
                    progress: animations.value,
                    progressColor: _theme.primaryColor,
                  ),
                  foregroundPainter: ProgressArc(
                    progress: 1,
                    width: widget.width,
                    progressColor: _theme.primaryColor.withOpacity(0.15),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            "${widget.isCount ? widget.current.format() : widget.current.formatInRupee()}\n",
                        style: _textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomTheme.darkGray,
                        ),
                        children: [
                          TextSpan(
                            text: widget.valueUnit,
                            style: _textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: CustomTheme.darkGray,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 2.hp),
          Container(
            width: widget.width + 10.wp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "${widget.minValue.format()}",
                  style: _textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "${widget.maxValue.format()}",
                  style: _textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
