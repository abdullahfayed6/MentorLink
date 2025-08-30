import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_colors.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';

class PlanOptionCard extends StatelessWidget {
  const PlanOptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final List<String> description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.symmetric(vertical: 8.h),
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? context.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Container(
              width: 22.w,
              height: 22.h,
              margin:  EdgeInsets.only(right: 12.w , top: 2.h),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.primary,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10.w,
                  height: 10.h,
                  decoration:  BoxDecoration(
                    color: context.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),

            // Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style:  Styles.textStyle16.copyWith(color: context.colorScheme.primary)
                  ),
                   SizedBox(height: 12.h),

                  // Description points
                  ...description.map((point) => Padding(
                    padding:  EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          "• ",
                          style:Styles.textStyle16.copyWith(color: context.colorScheme.onSecondaryContainer) ,
                        ),
                        Expanded(
                          child: Text(
                            point,
                            style: Styles.textStyle16.copyWith(color: context.colorScheme.onSecondaryContainer)
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}