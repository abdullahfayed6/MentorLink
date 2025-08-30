import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';

import '../../../../core/presentation/custom_text_field_form.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_styles.dart';

class BottomChatBotSection extends StatelessWidget {
  const BottomChatBotSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.mic_none,
                color: Color(0xFF2C6E49),
                size: 26.sp,
              ),
              onPressed: () {},
            ),
            Expanded(
              child: CustomTextField(
                borderColor: Colors.transparent,
                hint: "write a message ",
                hintStyle: Styles.textStyle16.copyWith(
                  color: context.colorScheme.onSecondaryContainer,
                ),
                style: Styles.textStyle16.copyWith(
                  color: context.colorScheme.onSecondaryContainer,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.image_outlined,
                color: const Color(0xFF2C6E49),
                size: 26.sp,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
