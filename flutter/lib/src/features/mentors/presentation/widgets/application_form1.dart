import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

import '../../../../core/theming/app_colors.dart';

class ApplicationForm1 extends StatefulWidget {
  const ApplicationForm1({super.key});

  @override
  State<ApplicationForm1> createState() => _ApplicationForm1State();
}

class _ApplicationForm1State extends State<ApplicationForm1> {
  String? _selectedGoal;
  String? _selectedTimeline;

  final List<String> _goals = [
    "I'm a student and looking for help with my studies",
    "I just graduated and need help with my career start",
    "I want to change careers",
    "I want to start a business",
    "I need mentorship for a personal project",
  ];

  final List<String> _timelines = [
    "I don't have a timeline in mind",
    "In a month or so",
    "Around 3 months",
    "Around a year",
    "More than a year",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Question 1 ----
          Text(
            "What best describes the goal of mentorship for you?",
            style: Styles.textStyle16.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),

          ..._goals.map(
            (goal) => RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              value: goal,
              groupValue: _selectedGoal,
              dense: true,
              visualDensity: const VisualDensity(vertical: -4),
              activeColor: context.colorScheme.onSurface,
              // radioSide: BorderSide(color: context.colorScheme.primary,width: 1,strokeAlign: BorderSide.strokeAlignCenter,),
              onChanged: (val) {
                setState(() => _selectedGoal = val);
              },
              title: Text(
                goal,
                style: Styles.textStyle14.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
          ),

          Divider(
            height: 25,
            color: AppColors.primaryLight,
            endIndent: 12.w,
            indent: 12.w,
          ),

          // ---- Question 2 ----
          Text(
            "When would you like to reach that goal?",
            style: Styles.textStyle16.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),

          ..._timelines.map(
            (timeline) => RadioListTile<String>(
              value: timeline,
              dense: true,
              visualDensity: const VisualDensity(vertical: -4),
              contentPadding: EdgeInsets.zero,

              groupValue: _selectedTimeline,
              activeColor: context.colorScheme.onSurface,

              // radioSide: BorderSide(color: context.colorScheme.primary,width: 1,strokeAlign: BorderSide.strokeAlignCenter,),
              onChanged: (val) {
                setState(() => _selectedTimeline = val);
              },
              title: Text(
                timeline,
                style: Styles.textStyle14.copyWith(
                  color: context.colorScheme.onSurface,
                ),
              ),
            ),
          ),

          SizedBox(height: 40.h), // just to add spacing for bottom button
        ],
      ),
    );
  }
}
