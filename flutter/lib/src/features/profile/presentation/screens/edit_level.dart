import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/features/profile/presentation/widgets/custom_radio_button.dart';

import '../../../../../generated/assets.dart';

class EditLevel extends StatelessWidget {
  const EditLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Edit Level"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 36.h, left: 24.w, right: 24.w),
          child: Column(
            children: [
              SizedBox(height: 36.h),
              SvgPicture.asset(Assets.editLevelImage, height: 181.h),
              SizedBox(height: 36.h),
              CustomRadioButtonGroup(
                title: "What’s your level?",
                options: ['Beginner', "Intermediate", "Advanced"],
                onChanged: (value) {},
                initialValue: "Beginner",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
