import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../theming/app_colors.dart';
import '../theming/app_styles.dart';

Future<void> showCustomDialog({
  required BuildContext context,
  required String title,
  required String negativeText,
  required String positiveText,
  VoidCallback? onNegative,
  VoidCallback? onPositive,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: SizedBox(
          width: 327.w,
          height: 215.h,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Center(
              child: Container(
                color: context.colorScheme.surface,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Styles.textStyle18,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            context.pop();
                            if (onPositive != null) onPositive();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryVariant,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 12.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            positiveText,
                            style: TextStyle(color: context.colorScheme.onSurface),
                          ),
                        ),
                        SizedBox(width: 2.w,),
                        OutlinedButton(
                          onPressed: () {
                            context.pop();
                            if (onNegative != null) onNegative();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.error),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 12.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            negativeText,
                            style: TextStyle(color: AppColors.error),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
