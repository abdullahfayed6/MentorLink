import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: context.colorScheme.primary,
            thickness: 2,
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            "OR",
            style: Styles.boldTextStyle16.copyWith(color: context.colorScheme.primary),
          ),
        ),
        Expanded(
          child: Divider(
            color:context.colorScheme.primary,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
