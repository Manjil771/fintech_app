import 'dart:math' as math;
import 'package:flutter/material.dart';

class ProgressArc extends CustomPainter {
  double progress;
  Color progressColor;
  double width;

  ProgressArc({
    required this.progress,
    required this.progressColor,
    required this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final _rect = Rect.fromLTRB(0, 0, width, width);
    const startAngle = -math.pi;
    final sweepAngle = math.pi * progress;
    const useCenter = false;
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    canvas.drawArc(_rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
