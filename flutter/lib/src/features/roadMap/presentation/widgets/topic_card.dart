import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class Topic extends StatelessWidget {
  final String title;
  final bool active;

  const Topic(this.title, {super.key, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: active
                ? Color(0xFF89C01C).withValues(alpha: .9)
                : Colors.grey,
            size: 12.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            title,
            style: Styles.textStyle10.copyWith(
              color: const Color(0xFF89C01C).withValues(alpha: .9),
              decoration: active ? TextDecoration.lineThrough : null,
              decorationThickness: 2,
              decorationColor: const Color(0xFF89C01C),
            ),
          ),
        ],
      ),
    );
  }
}
