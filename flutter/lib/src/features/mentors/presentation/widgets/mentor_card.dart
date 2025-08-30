import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/core/theming/app_styles.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';
import '../../../../core/theming/app_colors.dart';

class MentorCard extends StatefulWidget {
  const MentorCard({super.key, required this.mentorModel});

  final MentorModel mentorModel;

  @override
  State<MentorCard> createState() => _MentorCardState();
}

class _MentorCardState extends State<MentorCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 335.w,
        height: 200.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: context.colorScheme.primary, width: 1),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                // Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    widget.mentorModel.imageUrl,
                    width: 113.w,
                    height: 164.h,
                  ),
                ),
                SizedBox(width: 12.w),
                // Info Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Fast Responder tag
                      widget.mentorModel.benefit != null
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.sp,
                                    color: AppColors.primaryHeavy,
                                  ),
                                  Text(
                                    widget.mentorModel.benefit![0],
                                    style: Styles.textStyle10.copyWith(
                                      color: AppColors.primaryVariant,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                      SizedBox(height: 4.h),
                      // Name
                      Text(
                        widget.mentorModel.name,
                        style: Styles.textStyle16.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Rating
                      Row(
                        children: [
                          Icon(
                            Icons.star_border_outlined,
                            color: context.colorScheme.primary,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${widget.mentorModel.rating}",
                            style: Styles.textStyle12.copyWith(
                              color: context.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '(${widget.mentorModel.reviewsCount} reviews)',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Job info
                      Row(
                        children: [
                          Icon(
                            Icons.business_center_outlined,
                            color: Colors.grey,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.mentorModel.jobTitle,
                              style: Styles.textStyle10,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      // Description
                      Text(
                        widget.mentorModel.jobDescription,
                        style: Styles.textStyle12.copyWith(
                          color: context.colorScheme.primary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      // Hourly rate
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${widget.mentorModel.hourlyRate} EGP / Hour',
                          style: Styles.textStyle16.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 12.h,
              left: 11.w,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                child: Icon(
                  isSelected ? Icons.bookmark : Icons.bookmark_border,
                  color: context.colorScheme.surface,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Image.asset(
                widget.mentorModel.badge,
                height: 22.h,
                width: 33.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
