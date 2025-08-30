import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

class StepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: totalSteps,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final bool isActive = index <= currentStep;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            height: 12.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: isActive
                  ? context.colorScheme.primary
                  : context.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(12.r),
            ),
          );
        },
      ),
    );
  }
}
