import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class LevelTile extends StatelessWidget {
  const LevelTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap, required this.subTitle,
  });

  final String title;
  final String subTitle;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 88.h,
        width: 327.w,
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:  context.colorScheme.primary,
            width: isSelected? 2:1,
          ),
          color:  context.colorScheme.onPrimary,
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFF7FB11B),
              blurRadius: 10.r,
              spreadRadius: 5.r,
            )
          ]
              : [],
        ),
        child: ListTile(
          title: Text(
            title,
            style: Styles.textStyle16.copyWith(
              color: context.colorScheme.onSecondaryContainer,
            ),

          ),
          subtitle: Text(subTitle,style: Styles.textStyle16.copyWith(color: const Color(0xFF6C6C6C)),),
          trailing:  Icon(isSelected? Icons.check_circle :Icons.radio_button_unchecked,color: context.colorScheme.primary,)
        ),
      ),
    );
  }
}