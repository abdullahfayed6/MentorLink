import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/core/presentation/custom_title_with_textfield.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

import '../widgets/drop_down_menu.dart';
import '../widgets/edit_avatar.dart';

class EditMainInfo extends StatelessWidget {
  const EditMainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Edit Main Info"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: 1.sh,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36.h),
                  const EditAvatar(),
                  SizedBox(height: 36.h),
                  CustomTitleWithTextField(
                    initialValue: "GamalAzzam",
                    title: "Full Name",
                    icon: Icons.badge_outlined,
                    borderColor: context.colorScheme.primary,
                    hintStyle: Styles.textStyle14,
                    textStyle: Styles.textStyle16.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                    suffixIcon: Icon(
                      Icons.edit_outlined,
                      color: context.colorScheme.primary,
                    ),
                  ),

                  SizedBox(height: 36.h),
                  const CareerDropdown(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
