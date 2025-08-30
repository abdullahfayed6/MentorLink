import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class BottomNavButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool showGradient;
  final double height;
  final double width;
  final double radius;
  final Color textColor;
  final Color iconColor;
  final bool? showIcon;

  const BottomNavButton({
    super.key,
    required this.text,
    required this.onTap,
    this.showGradient = false,
    this.height = 42,
    this.width = 331,
    this.radius = 10,
    this.textColor = Colors.white,
    this.iconColor = Colors.white,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.r),
          color: showGradient ? null : Theme.of(context).colorScheme.primary,
          gradient: showGradient
              ? const LinearGradient(
                  colors: [Color(0xFFB2E44E), Color(0xFF43BBEF)],
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Styles.textStyle16.copyWith(color:textColor),
            ),
            SizedBox(width: 8.w),
            if (showIcon!)
              Icon(Icons.arrow_forward_ios, color: iconColor, size: 16.sp),
          ],
        ),
      ),
    );
  }
}
