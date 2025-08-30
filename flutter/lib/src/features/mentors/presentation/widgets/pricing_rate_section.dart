import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';

import '../../../../core/theming/app_styles.dart';

class PricingRateSection extends StatelessWidget {
  const PricingRateSection({super.key, required this.mentor});
final MentorModel mentor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 16.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Pricing Rate:",
            style: Styles.textStyle16.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          Text(
            "${mentor.hourlyRate} EGP / Hour",
            style: Styles.textStyle16.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
