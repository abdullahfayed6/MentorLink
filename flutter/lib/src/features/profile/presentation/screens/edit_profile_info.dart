import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/presentation/custom_check_box.dart';
import 'package:mentor_link/src/core/presentation/custom_row.dart';
import 'package:mentor_link/src/core/presentation/custom_title_with_textfield.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

import '../../../../core/presentation/custom_dialog.dart';
import '../widgets/action_text.dart';

class EditProfileInfo extends StatelessWidget {
  const EditProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Account Info"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 1.sh,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: Column(
                children: [
                  SizedBox(height: 36.h),
                  CustomTitleWithTextField(
                    title: "Email",
                    hintText: "ahmedkarim123@gmail.com",
                    icon: Icons.email_outlined,
                    borderColor: AppColors.accountHintColor,
                    hintStyle: Styles.textStyle14.copyWith(
                      color: AppColors.accountHintColor,
                    ),
                    prefixIconColor: AppColors.accountHintColor,
                    textStyle: Styles.textStyle20.copyWith(
                      color: AppColors.accountHintColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  const ActionText(text: "Update Email?"),
                  SizedBox(height: 20.h),
                  CustomTitleWithTextField(
                    title: "Phone Number",
                    hintText: "01092465880",
                    icon: Icons.call_outlined,
                    borderColor: AppColors.accountHintColor,
                    hintStyle: Styles.textStyle14.copyWith(
                      color: AppColors.accountHintColor,
                    ),
                    prefixIconColor: AppColors.accountHintColor,
                    textStyle: Styles.textStyle20.copyWith(
                      color: AppColors.accountHintColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  const ActionText(text: 'Update Phone Number?'),
                  SizedBox(height: 36.h),
                  CustomCheckBox(
                    onChanged: (value) {
                      debugPrint("$value");
                    },
                    text: "Get recent updates automatically",
                  ),
                  SizedBox(height: 16.h),
                  CustomCheckBox(
                    onChanged: (value) {
                      debugPrint("$value");
                    },
                    text: "Subscribe to our newsletter",
                  ),
                  SizedBox(height: 36.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48.h),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.error),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      showCustomDialog(
                        title: 'Are you sure you want to delete your account?',
                        context: context,
                        negativeText: 'Yes, Delete',
                        positiveText: 'No, I’ll stay!',
                      );
                    },
                    child: Text(
                      "Delete Account",
                      style: Styles.textStyle16.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
