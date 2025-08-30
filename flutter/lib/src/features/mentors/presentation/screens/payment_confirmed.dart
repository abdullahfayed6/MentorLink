import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/presentation/custom_button.dart';
import 'package:mentor_link/src/core/routing/routes.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';
import '../../../../../generated/assets.dart';

class PaymentConfirmed extends StatelessWidget {
  const PaymentConfirmed({super.key, required this.mentor});

  final MentorModel mentor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.paymentConfirmed,
                    height: 177.h,
                    width: 169.w,
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Your request has been sent to ${mentor.name.split(" ").first}, check your email\nfor confirmation!",
                    textAlign: TextAlign.center,
                    style: Styles.textStyle24.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                CustomButton(
                  text: "Done",
                  onPressed: () {
                    context.go(AppRoutePaths.rootScreen);
                  },
                  radius: 12.r,
                  backgroundColor: const Color(0xFF89C01C),
                ),
                const SizedBox(height: 16),
                SizedBox(height: 20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
