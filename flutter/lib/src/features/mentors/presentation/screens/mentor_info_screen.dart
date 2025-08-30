import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/header.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/benefit_chip.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/mentor_identity.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/pricing_rate_section.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/state_cards.dart';

import '../../../../core/presentation/custom_button.dart';
import '../widgets/skill_chip.dart';

class MentorInfoScreen extends StatefulWidget {
  const MentorInfoScreen({super.key, required this.mentor});

  final MentorModel mentor;

  @override
  State<MentorInfoScreen> createState() => _MentorInfoScreenState();
}

class _MentorInfoScreenState extends State<MentorInfoScreen> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Mentor Info",
        actionIcon: isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
        onActionPressed: () {
          setState(() {
            isBookmarked = !isBookmarked;
          });
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MentorIdentity(mentor: widget.mentor),
                Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Icon(
                      Icons.star_border_outlined,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "${widget.mentor.rating}",
                      style: Styles.textStyle16.copyWith(
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "(${widget.mentor.reviewsCount} reviews)",
                      style: Styles.textStyle12,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: widget.mentor.benefit!
                      .map((benefit) => BenefitChip(benefit: benefit))
                      .toList(),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Description",
                  style: Styles.textStyle16.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.mentor.jobDescription,
                  style: Styles.textStyle12.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Skills:",
                  style: Styles.textStyle16.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: widget.mentor.skills
                      .map((skill) => SkillChip(skill: skill))
                      .toList(),
                ),
                PricingRateSection(mentor: widget.mentor),
                const StateCards(),
              ],
            ),
          ),
        ),
      ),
      //i used here bottomNavigation bar to make the button is fixed position as the description may be change.
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 15.h, left: 20.w, right: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: "Apply now",
              onPressed: () {
                context.push(
                  AppRoutePaths.applicationForm,
                  extra: widget.mentor,
                );
              },
              radius: 12,
              backgroundColor: const Color(0xFF89C01C),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
