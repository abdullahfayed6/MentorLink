import 'dart:math' as math;

import 'package:flutter/material.dart';

class SegmentedCirclePainter extends CustomPainter {
  final int segments;
  final int activeSegments;
  final double strokeWidth;
  final double gapDegrees;
  final Color activeColor;
  final Color inactiveColor;

  const SegmentedCirclePainter({
    required this.segments,
    required this.activeSegments,
    required this.strokeWidth,
    required this.gapDegrees,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = (size.shortestSide / 2) - strokeWidth / 2;

    final Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = strokeWidth;

    final double gapRads = gapDegrees * (math.pi / 180.0);
    final double totalGaps = gapRads * segments;
    final double sweepPerSegment = (2 * math.pi - totalGaps) / segments;

    double startAngle = -math.pi / 2;

    final int activeCount = activeSegments < 0
        ? 0
        : (activeSegments > segments ? segments : activeSegments);

    for (int i = 0; i < segments; i++) {
      final bool isActive = i < activeCount;
      paint.color = isActive ? activeColor : inactiveColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepPerSegment,
        false,
        paint,
      );
      startAngle += sweepPerSegment + gapRads;
    }
  }

  @override
  bool shouldRepaint(covariant SegmentedCirclePainter oldDelegate) {
    return segments != oldDelegate.segments ||
        activeSegments != oldDelegate.activeSegments ||
        strokeWidth != oldDelegate.strokeWidth ||
        gapDegrees != oldDelegate.gapDegrees ||
        activeColor != oldDelegate.activeColor ||
        inactiveColor != oldDelegate.inactiveColor;
  }
}
