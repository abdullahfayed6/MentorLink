import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_link/src/core/presentation/custom_check_box.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

import '../../../../../generated/assets.dart';

class EditGoals extends StatelessWidget {
  const EditGoals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Edit Goals"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 24.0.w, left: 24.0.w, top: 28.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36.h),
              Center(child: SvgPicture.asset(Assets.editGoalImage)),
              SizedBox(height: 36.h),
              Text("What do you want to learn?", style: Styles.textStyle16),
              SizedBox(height: 16.h),
              CustomCheckBox(
                onChanged: (value) {},
                text: "Data Science",
                haveSize: true,
              ),
              CustomCheckBox(
                onChanged: (value) {},
                text: "UI / UX Design",
                haveSize: true,
              ),
              CustomCheckBox(
                onChanged: (value) {},
                text: "DevOps / Cloud Engineering",
                haveSize: true,
              ),
              CustomCheckBox(
                onChanged: (value) {},
                text: "Backend Development",
                haveSize: true,
              ),
              CustomCheckBox(
                onChanged: (value) {},
                text: "Frontend Development",
                haveSize: true,
              ),
              CustomCheckBox(
                onChanged: (value) {},
                text: "Project Management",
                haveSize: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
