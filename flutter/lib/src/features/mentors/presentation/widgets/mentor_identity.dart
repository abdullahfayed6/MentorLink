import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_link/src/core/extensions/build_context_extension.dart';
import 'package:mentor_link/src/features/mentors/presentation/data/models/mentor_card_models.dart';
import 'package:mentor_link/src/features/mentors/presentation/widgets/mentor_avatar.dart';

import '../../../../core/theming/app_styles.dart';

class MentorIdentity extends StatelessWidget {
  const MentorIdentity({super.key, required this.mentor});

  final MentorModel mentor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.0.h),
          child: MentorAvatar(mentor: mentor),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              mentor.name,
              style: Styles.textStyle20.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.business_center_outlined, size: 24.sp),
                Padding(
                  padding: EdgeInsets.only(top: 6.0.h),
                  child: Text(mentor.jobTitle, style: Styles.textStyle12),
                ),
              ],
            ),
            SizedBox(height: 25.h),
          ],
        ),
      ],
    );
  }
}
