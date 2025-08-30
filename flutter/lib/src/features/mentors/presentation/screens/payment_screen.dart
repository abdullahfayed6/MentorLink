import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/generated/assets.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_button.dart';
import 'package:mentor_link/src/core/presentation/header.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.mentor});
  final MentorModel mentor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "payment"),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h),
          child: Column(
            children: [
              Text(
                "Choose a suitable payment method:",
                style: Styles.textStyle20.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                height: 52.h,
                padding: EdgeInsets.only(left: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.primaryLight,
                ),
                child: Row(
                  children: [
                    Image.asset(Assets.instaPay, height: 28.h, width: 28.w),
                    SizedBox(width: 8.w),
                    Text(
                      "InstaPay",
                      style: Styles.textStyle16.copyWith(
                        color: context.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                height: 52.h,
                padding: EdgeInsets.only(left: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.primaryLight,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.payment,
                      size: 24.sp,
                      color: context.colorScheme.onSecondaryContainer,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Visa",
                      style: Styles.textStyle16.copyWith(
                        color: context.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(Assets.paymentImage, height: 245.h, width: 335.w),
              SizedBox(height: 155.h),
              CustomButton(
                text: "Get Started!",
                onPressed: () {
                  context.go(AppRoutePaths.paymentConfirmed, extra: mentor);
                },
                backgroundColor: const Color(0xFF89C01C),
                radius: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
