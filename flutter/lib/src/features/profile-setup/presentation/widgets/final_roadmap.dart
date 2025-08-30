import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/profile-setup/presentation/widgets/summary_row.dart';

import '../../../../../generated/assets.dart';

class FinalRoadmapScreen extends StatelessWidget {
  const FinalRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Awesome! Your Roadmap \n               is Ready',
          style: Styles.textStyle20.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'We’ve analyzed your preferences\n      and created a personalized\n       learning path just for you.',
          style: Styles.textStyle16.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 24),
        SvgPicture.asset(Assets.finishRoadMapImage, height: 185.h),
        const SizedBox(height: 24),
        Container(
          height: 193.h,
          width: 335.w,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: context.colorScheme.primary, width: 2),
            color: context.colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SummaryRow(title: "Track:", value: "UI/UX Design", isFirst: true),
              SummaryRow(title: "Level:", value: "Intermediate"),
              SummaryRow(title: "Commitment:", value: "3 days, 4h/day"),
              SummaryRow(title: "Goal:", value: "Internship"),
            ],
          ),
        ),
      ],
    );
  }
}
