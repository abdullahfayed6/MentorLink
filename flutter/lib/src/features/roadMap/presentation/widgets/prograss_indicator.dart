import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import '../../../../core/theming/app_styles.dart';
import 'gradient_progress_painter.dart';
import 'gradient_text.dart';

class GradientCircularProgress extends StatelessWidget {
  final double progress;//0.0 =>1.0

  const GradientCircularProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w,
      height: 160.h,
      child: CustomPaint(
        painter: GradientProgressPainter(progress: progress),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your\nProgress",
                textAlign: TextAlign.center,
                style: Styles.textStyle16.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 6.h),
              GradientText(
                text: "${(progress * 100).toInt()}%"
                ,
                style: Styles.boldTextStyle20,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF99D228),
                    Color(0xFFB8EC51),
                    Color(0xFF70CBF2),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

