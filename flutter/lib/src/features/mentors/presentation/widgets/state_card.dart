import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_styles.dart';
import 'gradient_icon.dart';

class StateCard extends StatelessWidget {
  const StateCard({super.key, required this.icon, required this.onTap, required this.text});
final IconData icon;
final VoidCallback onTap;
final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 66.w,
        width: 75.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),color: AppColors.primaryLight),
        child: Column(
          children: [
            SizedBox(height: 5.h,),
            GradientIcon(
              icon: icon,
              size: 32.sp,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF99D228),
                  Color(0xFFB8EC51),
                  Color(0xFF70CBF2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            SizedBox(height: 4.h,),
            Text(text,style: Styles.textStyle12.copyWith(color: AppColors.primaryVariant),)
          ],
        ),
      ),
    );
  }
}
