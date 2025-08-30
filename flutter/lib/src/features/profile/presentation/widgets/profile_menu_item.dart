import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';

import '../../../../core/theming/app_styles.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.requiredIcon,
    required this.title,
     this.onTap,
    this.trailing,
    this.showArrow = false, this.borderColor ,
  });

  final IconData requiredIcon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        height: 56.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: borderColor?? context.colorScheme.onSurface, width: 1.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(requiredIcon, color: title =="Log Out"? AppColors.error: context.colorScheme.primary),
                SizedBox(width: 4.w),
                Text(title, style: Styles.textStyle16.copyWith(color: title =="Log Out"? AppColors.error:null)),
              ],
            ),
            if (trailing != null) trailing!,
            if (trailing == null && showArrow)
              Icon(Icons.arrow_forward_ios, size: 20.sp, color: context.colorScheme.onSurface),
          ],
        ),
      ),
    );
  }
}
