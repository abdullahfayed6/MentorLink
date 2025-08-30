import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFFA9E139),
    this.radius = 4.0,
    this.minHeight = 48,
    this.minWidth = double.infinity,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? radius;
  final double? minHeight;
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(minWidth!.w, minHeight!.h),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Styles.textStyle16.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colorScheme.surface,
        ),
      ),
    );
  }
}
