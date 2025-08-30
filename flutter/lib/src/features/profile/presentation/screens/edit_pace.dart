import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';

import '../../../../../generated/assets.dart';
import '../widgets/custom_radio_button.dart';

class EditPace extends StatelessWidget {
  const EditPace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Edit Pace"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(right: 24.0.w, left: 24.0.w, top: 28.0.h),
          child: Column(
            children: [
              SvgPicture.asset(Assets.editPaceImage, height: 171.h),
              SizedBox(height: 36.h),
              CustomRadioButtonGroup(
                title:
                    'How many days a week can you give to develop your skills?',

                onChanged: (value) {},
                options: [
                  "1 day",
                  "2 - 4 days",
                  "5 - 6 days",
                  "All week (we don’t recommend)",
                ],
                initialValue: "2 - 4 days",
              ),
              SizedBox(height: 36.h),
              CustomRadioButtonGroup(
                title:
                    "How many hours a day can you give to develop your skills?",
                options: ["1 hour", "3 hours", "5 hours"],
                initialValue: "5 hours",
                onChanged: (value) {
                  debugPrint("Hours selected: $value");
                },
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
    );
  }
}
