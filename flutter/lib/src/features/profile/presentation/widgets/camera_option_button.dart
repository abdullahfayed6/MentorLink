import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../../../../core/theming/app_styles.dart';

class CameraOptionButton extends StatelessWidget {
  const CameraOptionButton({super.key, required this.text, required this.icon, required this.onTap});
final String text;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
        height: 40.h,
        width: 189.w,

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r),
            border: Border.all(color: context.colorScheme.primary)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: context.colorScheme.primary,
            ),
            Text(text,style: Styles.textStyle16,)
          ],
        ),
      ),
    );
  }
}
