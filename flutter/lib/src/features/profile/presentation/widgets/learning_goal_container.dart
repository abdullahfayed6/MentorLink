import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_styles.dart';

class LearningGoalContainer extends StatelessWidget {
  const LearningGoalContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.leadingIcon,
    required this.onPressed,
  });

  final String title, subTitle;
  final IconData leadingIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      height: 73.h,
      width: 327.w,
      decoration: BoxDecoration(
        color: const Color(0xFFEBFDC6),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: ListTile(
        leading: Icon(leadingIcon, color: AppColors.onSecondary),
        title: Text(
          title,
          style: Styles.textStyle16.copyWith(color: AppColors.onSecondary),
        ),
        subtitle: Text(
          subTitle,
          style: Styles.textStyle12.copyWith(color: AppColors.onSecondary),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.edit_outlined, color: AppColors.primaryHeavy),
        ),
      ),
    );
  }
}
