import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_values.dart';

class CustomContainers extends StatelessWidget {
  const CustomContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          margin: EdgeInsets.only(right: AppMargin.m10.w),
          height: 44.h,
          width: 44.w,
          decoration: BoxDecoration(
            color: const Color(0xFFEBFDC6),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: context.colorScheme.primary),
          ),
        );
      }),
    );
  }
}
