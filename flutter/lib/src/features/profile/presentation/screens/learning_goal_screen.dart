import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/profile/presentation/widgets/learning_goal_container.dart';

import '../widgets/interests_container.dart';

class LearningGoalScreen extends StatelessWidget {
  const LearningGoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> interests = [
      "Data Science",
      "Machine Learning",
      "AI",
      "Deep Learning",
      "Python",
      "Data Analysis",
      "Data Cleaning",
    ];

    return Scaffold(
      appBar: const CustomAppBar(text: "Learning Goals & \n Preferences"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 28.h, left: 24.0.w, right: 24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36.h),
              LearningGoalContainer(
                title: "Your Goal",
                subTitle: "Learn Data Science",
                leadingIcon: Icons.track_changes_outlined,
                onPressed: () {
                  //
                  context.push(AppRoutePaths.editGoalsScreen);
                },
              ),
              LearningGoalContainer(
                title: "Pace",
                subTitle: "2 - 4 days / Week | 5 Hrs / Day",
                leadingIcon: Icons.hourglass_empty,
                onPressed: () {
                  ///
                  context.push(AppRoutePaths.editPaceScreen);
                },
              ),
              LearningGoalContainer(
                title: "Skill Level",
                subTitle: "Beginner",
                leadingIcon: Icons.assignment_outlined,
                onPressed: () {
                  //edit level here
                  context.push(AppRoutePaths.editLevelScreen);
                },
              ),
              SizedBox(height: 12.h),
              Divider(thickness: 1, color: context.colorScheme.primary),
              SizedBox(height: 36.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Interests",
                    style: Styles.textStyle20.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ///here we go interests screen
                      context.push(AppRoutePaths.editInterestsScreen);
                    },
                    child: Icon(
                      Icons.edit_outlined,
                      color: AppColors.primaryHeavy,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              const InterestsContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
