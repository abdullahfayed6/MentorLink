import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'segmented_circle_painter.dart';

class ProgressRingButton extends StatelessWidget {
  final int totalSegments;
  final int activeSegments;
  final VoidCallback onPressed;

  const ProgressRingButton({
    super.key,
    required this.totalSegments,
    required this.activeSegments,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonSize = 70.r;
    final double ringSize = 90.r;
    final double stroke = 4.r;

    return SizedBox(
      width: ringSize,
      height: ringSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              size: Size(ringSize, ringSize),
              painter: SegmentedCirclePainter(
                segments: totalSegments,
                activeSegments: activeSegments,
                strokeWidth: stroke,
                gapDegrees: 12,
                activeColor: Colors.white,
                inactiveColor: Colors.transparent,
              ),
            ),
          ),
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: const BoxDecoration(
              color: Color(0xFFA9E139),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onPressed,
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
              ),
              icon: const Icon(Icons.arrow_forward, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
