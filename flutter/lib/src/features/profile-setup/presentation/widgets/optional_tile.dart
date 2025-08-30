import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.text,
     required this.imageUrl,
    required this.isSelected,
    required this.onTap, this.showTrailing = false,
  });

  final String text;
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;
  final bool showTrailing;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 68.h,
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
          leading: SvgPicture.asset(imageUrl),
          title: Text(
            text,
            style: Styles.textStyle12.copyWith(
              color: context.colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
            ),

          ),
          trailing: showTrailing? Icon(isSelected? Icons.check_circle:Icons.radio_button_off_outlined,color: context.colorScheme.primary,):null ,
        ),
      ),
    );
  }
}