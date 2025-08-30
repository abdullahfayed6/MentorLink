import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

import '../../../../../generated/assets.dart';

class CustomSuccessSign extends StatefulWidget {
  const CustomSuccessSign({
    super.key,
    required this.text,
    this.navigateToPath,
    this.autoNavigateDelay,
  });

  final String text;
  final String? navigateToPath;
  final Duration? autoNavigateDelay;

  @override
  State<CustomSuccessSign> createState() => _CustomSuccessSignState();
}

class _CustomSuccessSignState extends State<CustomSuccessSign> {
  @override
  void initState() {
    super.initState();
    if (widget.navigateToPath != null) {
      final delay = widget.autoNavigateDelay ?? const Duration(seconds: 3);
      Future.delayed(delay, () {
        if (!mounted) return;
        context.go(widget.navigateToPath!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.certificateSuccessImage,
              width: 114.w,
              height: 114.h,
            ),
            SizedBox(height: 40.h),
            Text(
              widget.text,
              style: Styles.boldTextStyle24,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to ',
                    style: Styles.textStyle14.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'MentorLink',
                    style: TextStyle(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  TextSpan(
                    text: ', your journey starts here!',
                    style: Styles.textStyle14.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
